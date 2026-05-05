// app.js

// --- CONSTANTS & CONFIG ---
const STORAGE_USERS = 'mission_users';
const STORAGE_REQUESTS = 'mission_requests';
const STORAGE_SESSION = 'mission_session';

const CATEGORIES = {
    'Social': { color: '#a78bfa', icon: '💬', className: 'cat-social' },
    'Transport': { color: '#38bdf8', icon: '🚗', className: 'cat-transport' },
    'Delivery': { color: '#fb923c', icon: '📦', className: 'cat-delivery' },
    'Goods': { color: '#4ade80', icon: '🛍️', className: 'cat-goods' },
    'Social Animals': { color: '#f472b6', icon: '🐾', className: 'cat-social-animals' },
    'Repairs': { color: '#f87171', icon: '🔧', className: 'cat-repairs' },
    'Special': { color: '#f5c518', icon: '⭐', className: 'cat-special' }
};

// --- DATA LAYER: USERS ---
function getUsers() {
    return JSON.parse(localStorage.getItem(STORAGE_USERS) || '[]');
}

function getUserById(id) {
    const users = getUsers();
    return users.find(u => u.id === id) || null;
}

function getUserByEmail(email) {
    const users = getUsers();
    return users.find(u => u.email === email) || null;
}

function saveUser(user) {
    const users = getUsers();
    const index = users.findIndex(u => u.id === user.id);
    if (index > -1) {
        users[index] = user;
    } else {
        users.push(user);
    }
    localStorage.setItem(STORAGE_USERS, JSON.stringify(users));
}

// --- DATA LAYER: REQUESTS ---
function getRequests(filters = {}) {
    let reqs = JSON.parse(localStorage.getItem(STORAGE_REQUESTS) || '[]');

    if (filters.category) reqs = reqs.filter(r => r.category === filters.category);
    if (filters.status) reqs = reqs.filter(r => r.status === filters.status);
    if (filters.requesterId) reqs = reqs.filter(r => r.requesterId === filters.requesterId);
    if (filters.providerId) reqs = reqs.filter(r => r.providerId === filters.providerId);
    if (filters.search) {
        const lowerSearch = filters.search.toLowerCase();
        reqs = reqs.filter(r =>
            r.title.toLowerCase().includes(lowerSearch) ||
            r.location.toLowerCase().includes(lowerSearch)
        );
    }

    // Sort logic
    if (filters.sortBy === 'Nearest') {
        // Mock sorting: just return as is or alphabetical by location if real geo unavailable
        reqs.sort((a,b) => a.location.localeCompare(b.location));
    } else if (filters.sortBy === 'Highest Budget') {
        reqs.sort((a,b) => b.budget - a.budget);
    } else if (filters.sortBy === 'Ending Soon') {
        reqs.sort((a,b) => new Date(a.deadline) - new Date(b.deadline));
    } else { // Latest
        reqs.sort((a,b) => new Date(b.postedDate) - new Date(a.postedDate));
    }

    return reqs;
}

function getRequestById(id) {
    const reqs = getRequests();
    return reqs.find(r => r.id === id) || null;
}

function saveRequest(req) {
    const reqs = JSON.parse(localStorage.getItem(STORAGE_REQUESTS) || '[]');
    const index = reqs.findIndex(r => r.id === req.id);
    if (index > -1) {
        reqs[index] = req;
    } else {
        reqs.push(req);
    }
    localStorage.setItem(STORAGE_REQUESTS, JSON.stringify(reqs));
}

function deleteRequest(id) {
    let reqs = getRequests();
    reqs = reqs.filter(r => r.id !== id);
    localStorage.setItem(STORAGE_REQUESTS, JSON.stringify(reqs));
}

// --- DATA LAYER: MESSAGES ---
function addMessage(requestId, senderId, text) {
    const req = getRequestById(requestId);
    if (req) {
        if (!req.messages) req.messages = [];
        req.messages.push({
            id: 'msg_' + Date.now(),
            senderId: senderId,
            text: text,
            timestamp: new Date().toISOString()
        });
        saveRequest(req);
    }
}

function addReview(userId, reviewerId, rating, comment) {
    const user = getUserById(userId);
    if (user) {
        if (!user.reviews) user.reviews = [];
        user.reviews.push({
            reviewerId,
            rating,
            comment,
            date: new Date().toISOString()
        });
        saveUser(user);
    }
}

// --- AUTH ---
function login(email, password) {
    const user = getUserByEmail(email);
    if (user && user.password === password) {
        localStorage.setItem(STORAGE_SESSION, user.id);
        return true;
    }
    return false;
}

function logout() {
    localStorage.removeItem(STORAGE_SESSION);
    window.location.href = 'login.html';
}

function getSession() {
    const sessionId = localStorage.getItem(STORAGE_SESSION);
    if (sessionId) {
        return getUserById(sessionId);
    }
    return null;
}

function register(userData) {
    if (getUserByEmail(userData.email)) {
        return false; // Email exists
    }
    const newUser = {
        id: 'u_' + Date.now(),
        joinDate: new Date().toISOString(),
        reviews: [],
        ...userData
    };
    saveUser(newUser);
    localStorage.setItem(STORAGE_SESSION, newUser.id);
    return true;
}

function requireAuth() {
    if (!getSession()) {
        window.location.href = 'login.html';
    }
}

// --- UTILS ---
function generateId() {
    return 'id_' + Math.random().toString(36).substr(2, 9);
}

function formatDeadline(isoDate) {
    const d = new Date(isoDate);
    const now = new Date();
    const diffTime = d - now;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays < 0) return "Overdue";
    if (diffDays === 0) return "Today";
    if (diffDays === 1) return "1 day left";
    return diffDays + " days left";
}

function formatBudget(amount, currency) {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: currency }).format(amount);
}

function getInitialsAvatar(name, color = '#00e5c3') {
    const initials = name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase();
    return `data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="%23${color.substring(1)}"/><text x="50" y="50" font-family="Arial" font-size="40" font-weight="bold" fill="white" text-anchor="middle" dominant-baseline="central">${initials}</text></svg>`;
}

function showToast(message) {
    const container = document.getElementById('toast-container') || createToastContainer();
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.innerText = message;
    container.appendChild(toast);

    // Trigger animation
    setTimeout(() => toast.classList.add('show'), 10);

    // Remove after 3s
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

function createToastContainer() {
    const container = document.createElement('div');
    container.id = 'toast-container';
    container.className = 'toast-container';
    document.body.appendChild(container);
    return container;
}

function pageTransition(targetUrl) {
    document.body.classList.add('fade-out');
    setTimeout(() => {
        window.location.href = targetUrl;
    }, 300);
}

// Override link clicks for smooth transitions
document.addEventListener('DOMContentLoaded', () => {
    // Fade in
    document.body.classList.remove('fade-out');

    document.querySelectorAll('a').forEach(link => {
        // Only internal links without target="_blank"
        if (link.href && link.href.startsWith(window.location.origin) && link.target !== "_blank" && !link.hasAttribute('download')) {
            link.addEventListener('click', (e) => {
                // Ignore hash links or links with special behaviors
                if (link.getAttribute('href').startsWith('#')) return;
                e.preventDefault();
                pageTransition(link.href);
            });
        }
    });
});


// --- SEED LOGIC ---
const DUMMY_ACCOUNTS = [
    { id: 'u1', name: 'Maria Santos', flag: '🇯🇵', role: 'Both', email: 'maria@demo.com', password: 'demo123', location: 'Tokyo, Japan', bio: 'Expat in Tokyo. Happy to help with local errands and cultural exchange', joinDate: '2023-01-15T10:00:00Z', reviews: [{reviewerId:'u2', rating: 5, comment:'Amazing help!'}], missionsPosted: 5, tasksCompleted: 12 },
    { id: 'u2', name: 'James Okafor', flag: '🇳🇬', role: 'Provider', email: 'james@demo.com', password: 'demo123', location: 'Lagos, Nigeria', bio: 'Local fixer in Lagos. Can source, ship, and handle anything across West Africa', joinDate: '2023-03-20T14:30:00Z', reviews: [], missionsPosted: 0, tasksCompleted: 24 },
    { id: 'u3', name: 'Léa Moreau', flag: '🇫🇷', role: 'Requester', email: 'lea@demo.com', password: 'demo123', location: 'Paris, France', bio: 'Digital nomad. Always looking for help with local tasks while traveling', joinDate: '2023-06-10T09:15:00Z', reviews: [], missionsPosted: 34, tasksCompleted: 0 },
    { id: 'u4', name: 'Arjun Mehta', flag: '🇮🇳', role: 'Both', email: 'arjun@demo.com', password: 'demo123', location: 'Mumbai, India', bio: 'Tech guy in Mumbai. Can help with repairs, research, and local sourcing', joinDate: '2023-08-05T16:45:00Z', reviews: [], missionsPosted: 8, tasksCompleted: 15 },
    { id: 'u5', name: 'Sophie Müller', flag: '🇩🇪', role: 'Provider', email: 'sophie@demo.com', password: 'demo123', location: 'Berlin, Germany', bio: 'Translator, researcher, and local guide in Berlin', joinDate: '2023-11-01T11:20:00Z', reviews: [], missionsPosted: 2, tasksCompleted: 18 }
];

const SEED_MISSIONS = [
    { id: 'm1', title: "Source a Patek Philippe dealer open on Sunday in Geneva", category: "Goods", budget: 80, currency: "USD", requesterId: "u3", providerId: null, status: "open", location: "Geneva, Switzerland", deadline: "2025-05-10T00:00:00Z", online: false, description: "I am arriving in Geneva this Sunday and need to find a reputable Patek Philippe authorized dealer that is actually open. Many are closed on weekends. I need someone local to call around, verify opening hours, and book me an appointment if possible. Will pay extra if you can accompany me as a translator.", postedDate: "2024-05-01T08:00:00Z", messages: [] },
    { id: 'm2', title: "Live video walk of Tsukiji fish market at 5am Tokyo time", category: "Special", budget: 30, currency: "USD", requesterId: "u4", providerId: null, status: "open", location: "Tokyo, Japan", deadline: "2024-05-15T00:00:00Z", online: true, description: "I'm doing research for a culinary project and need footage of the outer market early in the morning. I'd like someone to jump on a 30-minute WhatsApp video call with me, walk through the stalls, and let me ask questions about the seafood on display. No commentary needed, just point the camera where I ask.", postedDate: "2024-05-02T09:00:00Z", messages: [] },
    { id: 'm3', title: "Ship 2kg dried suya spice blend to Zurich, Switzerland", category: "Delivery", budget: 45, currency: "USD", requesterId: "u1", providerId: "u2", status: "in_progress", location: "Lagos, Nigeria", deadline: "2024-05-20T00:00:00Z", online: false, description: "I severely miss authentic suya spice and the stuff here in Europe isn't right. I need someone in Lagos to buy 2kg of high-quality Yaji (suya spice) from a good vendor, vacuum seal it if possible, and ship it via DHL to my address in Zurich. I will cover the DHL shipping costs separately, the $45 is just for your time and the spice cost.", postedDate: "2024-04-28T10:00:00Z", messages: [{id:'msg1', senderId:'u2', text:'I can source this from my trusted vendor in Yaba today.', timestamp:'2024-04-29T10:00:00Z'}, {id:'msg2', senderId:'u1', text:'Perfect, let me know when you have it.', timestamp:'2024-04-29T10:15:00Z'}] },
    { id: 'm4', title: "Translate 1-page German residential lease to English", category: "Social", budget: 25, currency: "USD", requesterId: "u3", providerId: null, status: "open", location: "Online", deadline: "2024-05-08T00:00:00Z", online: true, description: "I am looking at renting an apartment in Berlin but the landlord sent the contract entirely in German. It's a standard one-page document. I need a native German speaker to translate the key clauses for me and point out anything unusual. We can just do this over a quick Zoom call or you can send written notes.", postedDate: "2024-05-03T11:00:00Z", messages: [] },
    { id: 'm5', title: "Replace cracked screen on OnePlus 12 in Bandra, Mumbai", category: "Repairs", budget: 60, currency: "USD", requesterId: "u4", providerId: null, status: "open", location: "Mumbai, India", deadline: "2024-05-12T00:00:00Z", online: false, description: "My phone fell and the screen is shattered. I am staying in a hotel in Bandra West and don't have time to find a repair shop. I need someone reliable to come pick up the phone, take it to a trusted repair center to have the screen replaced, and bring it back to me. I will pay for the actual screen replacement directly to the shop.", postedDate: "2024-05-04T12:00:00Z", messages: [] },
    { id: 'm6', title: "Book a table at a Michelin-starred restaurant in Lyon for 4 on Saturday", category: "Transport", budget: 20, currency: "USD", requesterId: "u5", providerId: "u3", status: "completed", location: "Lyon, France", deadline: "2024-04-20T00:00:00Z", online: true, description: "I am trying to get a last-minute reservation for 4 people at a top restaurant in Lyon for this Saturday night. Many places don't answer emails and my French on the phone isn't great. Need a local to call around and secure a table at a 1, 2, or 3 star place. Will tip extra if it's Paul Bocuse.", postedDate: "2024-04-15T13:00:00Z", messages: [] },
    { id: 'm7', title: "Scout and photograph 3 coworking spaces in Nairobi CBD", category: "Special", budget: 50, currency: "USD", requesterId: "u2", providerId: null, status: "open", location: "Nairobi, Kenya", deadline: "2024-05-25T00:00:00Z", online: false, description: "My team is planning to open a small hub in Nairobi. Before I fly down, I need someone to visit 3 specific coworking spaces in the Central Business District. I need you to take photos of the desk areas, check the internet speed (run a speed test), and ask the manager about private office availability for 4 people.", postedDate: "2024-05-05T08:30:00Z", messages: [] },
    { id: 'm8', title: "Queue for Nike Air Jordan 4 'Bred Reimagined' drop in SoHo NYC, size EU42", category: "Special", budget: 150, currency: "USD", requesterId: "u3", providerId: null, status: "open", location: "New York, USA", deadline: "2024-05-18T00:00:00Z", online: false, description: "I need a dedicated sneakerhead or patient person to queue at the Nike store in SoHo for the upcoming Jordan drop. You'll likely need to be there very early morning. I need size US 8.5 (EU 42). The $150 budget is for your time queuing. I will transfer the cost of the shoes to you while you are in line once availability is confirmed.", postedDate: "2024-05-01T14:00:00Z", messages: [] },
    { id: 'm9', title: "Find a native Brazilian Portuguese conversation partner in São Paulo", category: "Social", budget: 35, currency: "USD", requesterId: "u4", providerId: null, status: "open", location: "Online", deadline: "2024-05-30T00:00:00Z", online: true, description: "I'm moving to São Paulo for work next month and my Portuguese is rusty. I'm looking for a native speaker living in SP to have a 1-hour casual video chat with me to practice. I specifically want to learn Paulistano slang and get some tips on good neighborhoods to live in.", postedDate: "2024-05-02T15:00:00Z", messages: [] },
    { id: 'm10', title: "Walk my golden retriever in South Kensington 3x this week, 45min each", category: "Social Animals", budget: 90, currency: "GBP", requesterId: "u1", providerId: null, status: "open", location: "London, UK", deadline: "2024-05-14T00:00:00Z", online: false, description: "I am recovering from a sprained ankle and cannot give my active Golden Retriever the exercise he needs. Need an experienced dog walker to take him out for 45 minutes on Tuesday, Thursday, and Saturday this week around Hyde Park. He pulls a bit on the leash so you need to be strong.", postedDate: "2024-05-04T16:00:00Z", messages: [] },
    { id: 'm11', title: "Buy and ship 12-pack Bundaberg Ginger Beer to Lausanne, Switzerland", category: "Goods", budget: 55, currency: "USD", requesterId: "u3", providerId: null, status: "open", location: "Sydney, Australia", deadline: "2024-06-01T00:00:00Z", online: false, description: "I can't find proper Australian ginger beer here in Switzerland. I need someone to buy a 12-pack of Bundaberg (glass bottles) and ship them securely packed to my address. The budget covers your effort to pack it well so it doesn't break. Shipping costs will be reimbursed separately.", postedDate: "2024-05-03T17:00:00Z", messages: [] },
    { id: 'm12', title: "Repair vintage Casio F-91W with dead battery and cracked lens, Osaka", category: "Repairs", budget: 40, currency: "USD", requesterId: "u2", providerId: "u4", status: "in_progress", location: "Osaka, Japan", deadline: "2024-05-22T00:00:00Z", online: false, description: "I bought a vintage Casio at a flea market but it needs a new battery and the plastic crystal is scratched/cracked. Looking for someone handy with small electronics in Osaka to replace the battery and polish or replace the lens. I'll drop it off and pick it up from you.", postedDate: "2024-04-30T18:00:00Z", messages: [] },
    { id: 'm13', title: "Buy 500g of fresh Oaxacan negro mole paste from Mercado Benito Juárez", category: "Goods", budget: 30, currency: "USD", requesterId: "u5", providerId: null, status: "open", location: "Oaxaca, Mexico", deadline: "2024-05-28T00:00:00Z", online: false, description: "I need authentic, fresh mole negro paste straight from the market in Oaxaca. Please buy 500g from a reputable vendor in Mercado Benito Juárez, vacuum seal it, and ship it to me in Berlin. I'll pay for the DHL shipping on top of this fee.", postedDate: "2024-05-04T19:00:00Z", messages: [] },
    { id: 'm14', title: "K-beauty haul from Olive Young Myeongdong: specific 8-item list provided", category: "Goods", budget: 180, currency: "USD", requesterId: "u1", providerId: null, status: "open", location: "Seoul, South Korea", deadline: "2024-05-20T00:00:00Z", online: false, description: "I have a specific list of 8 skincare items that are either sold out online or much cheaper in-store in Korea. I need someone to go to the flagship Olive Young in Myeongdong, buy these exact items (will provide photos), and ship the box to me in Tokyo. The $180 covers your shopping time. Product cost and shipping will be paid separately.", postedDate: "2024-05-05T07:00:00Z", messages: [] },
    { id: 'm15', title: "Photograph the Dubai Frame at golden hour — 10 high-res shots for portfolio", category: "Special", budget: 200, currency: "USD", requesterId: "u4", providerId: "u2", status: "completed", location: "Dubai, UAE", deadline: "2024-04-10T00:00:00Z", online: false, description: "I am an architect putting together a presentation and need high-quality, professional photographs of the Dubai Frame taken during golden hour. Looking for a local photographer with a DSLR or mirrorless camera. I need 10 edited, high-res JPEGs showcasing different angles and the context.", postedDate: "2024-03-25T08:00:00Z", messages: [] },
    { id: 'm16', title: "Check on my apartment in Palermo, Buenos Aires after this week's flooding", category: "Special", budget: 80, currency: "USD", requesterId: "u3", providerId: null, status: "open", location: "Buenos Aires, Argentina", deadline: "2024-05-09T00:00:00Z", online: false, description: "I own a ground-floor apartment in Palermo Soho. I saw on the news there was heavy flooding in the area. I'm currently in Paris and need a reliable local to go to the address (I will provide keys via a lockbox), check for any water damage, take photos of every room, and ensure it's secure.", postedDate: "2024-05-05T09:00:00Z", messages: [] },
    { id: 'm17', title: "Find a reputable Muay Thai gym in Chiang Mai for a 2-week drop-in", category: "Social", budget: 15, currency: "USD", requesterId: "u1", providerId: null, status: "open", location: "Chiang Mai, Thailand", deadline: "2024-06-15T00:00:00Z", online: true, description: "I'm traveling to Chiang Mai next month and want to train. I don't want a tourist trap gym. I need a local or an expat living there to recommend a solid, authentic Muay Thai gym that accepts 2-week drop-ins, and preferably one that isn't too crowded. A quick WhatsApp call to discuss would be great.", postedDate: "2024-05-01T10:00:00Z", messages: [] },
    { id: 'm18', title: "Source a bottle of Kanonkop Pinotage 2019 vintage in Cape Town", category: "Goods", budget: 70, currency: "USD", requesterId: "u5", providerId: null, status: "open", location: "Cape Town, South Africa", deadline: "2024-05-25T00:00:00Z", online: false, description: "Trying to track down a specific vintage (2019) of Kanonkop Pinotage for a friend's anniversary. Need someone in Cape Town to call or visit specialized wine merchants or the estate itself to find a bottle, purchase it, and arrange secure shipping to Germany.", postedDate: "2024-05-02T11:00:00Z", messages: [] },
    { id: 'm19', title: "Pick up and ship a handmade azulejo tile set ordered from a Porto artisan", category: "Delivery", budget: 65, currency: "USD", requesterId: "u3", providerId: null, status: "open", location: "Porto, Portugal", deadline: "2024-05-18T00:00:00Z", online: false, description: "I commissioned a custom set of tiles from a small shop in Porto that doesn't offer international shipping. The order is ready. I need someone to physically go to the shop, pick up the heavy box (approx 15kg), and drop it off at a local UPS or DHL center for shipping to France.", postedDate: "2024-05-04T12:00:00Z", messages: [] },
    { id: 'm20', title: "Recommend and book a private hawker food tour for 2 in Singapore next Friday", category: "Special", budget: 120, currency: "USD", requesterId: "u4", providerId: null, status: "open", location: "Singapore", deadline: "2024-05-10T00:00:00Z", online: true, description: "My wife and I are foodies arriving in Singapore next week. We don't want a standard commercial tour. We want a passionate local foodie to design a 3-hour evening itinerary hitting the best, off-the-beaten-path hawker stalls. Budget is for your time to plan and guide us virtually or in-person if you prefer.", postedDate: "2024-05-05T13:00:00Z", messages: [] }
];

function seedIfEmpty() {
    if (!localStorage.getItem(STORAGE_USERS) || JSON.parse(localStorage.getItem(STORAGE_USERS)).length === 0) {
        localStorage.setItem(STORAGE_USERS, JSON.stringify(DUMMY_ACCOUNTS));
    }
    if (!localStorage.getItem(STORAGE_REQUESTS) || JSON.parse(localStorage.getItem(STORAGE_REQUESTS)).length === 0) {
        // Adjust dates to be relevant to current time so "ending soon" filters make sense
        const now = new Date();
        const adjustedMissions = SEED_MISSIONS.map((m, index) => {
            const mCopy = {...m};
            // Set some deadlines in the future (3-15 days)
            const futureDate = new Date(now);
            futureDate.setDate(now.getDate() + 3 + (index % 12));
            mCopy.deadline = futureDate.toISOString();

            const pastDate = new Date(now);
            pastDate.setDate(now.getDate() - (index % 10) - 1);
            mCopy.postedDate = pastDate.toISOString();

            return mCopy;
        });

        localStorage.setItem(STORAGE_REQUESTS, JSON.stringify(adjustedMissions));
    }
}

// Call seed immediately
seedIfEmpty();
