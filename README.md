# 📚 Bookify — Online Bookstore (Ruby on Rails)

Bookify is a full-stack Ruby on Rails marketplace where users can publish, browse, buy, and sell books. It includes user authentication, a shopping cart and checkout flow with Stripe, real-time messaging between users, background job processing with Sidekiq, and an admin dashboard powered by Active Admin.

## ✨ Features

- **Book catalog** — create, edit, delete, and browse books with cover images and downloadable book files (via Active Storage)
- **"My Books" filter** — view only the books you've published
- **Shopping cart** — add/remove books, increase/decrease quantities, automatic price totals
- **Checkout & payments** — Stripe Checkout integration for paying for cart contents
- **Purchase tracking** — each book tracks its total number of purchases
- **Authentication & authorization** — Devise for user sign-up/login, Pundit-based policies for ownership checks (e.g., only the author can edit/delete their book)
- **Real-time chat** — direct messaging between users via Action Cable (WebSockets), broadcast through a background job
- **Email notifications** — Action Mailer setup (e.g., notifying authors when a book is published), with Letter Opener for previewing emails in development
- **Admin dashboard** — Active Admin panel for managing users, books, and admin accounts, with Ransack-powered search/filtering
- **Background jobs** — Sidekiq + Solid Queue for async processing, with a Sidekiq Web UI restricted to admins
- **PWA-ready** — manifest and service worker included

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Ruby on Rails 8.1 (Ruby 3.4.1) |
| Database | SQLite |
| Frontend | ERB templates, Bootstrap 5, Sass |
| JS / Reactivity | Hotwire (Turbo + Stimulus), Importmap |
| Auth | Devise |
| Authorization | Pundit |
| Admin | Active Admin |
| Payments | Stripe (via the `pay` gem) |
| Background jobs | Sidekiq, Solid Queue, Solid Cache, Solid Cable |
| File uploads | Active Storage |
| Real-time | Action Cable |
| Testing | RSpec, Capybara, Minitest, Factory Bot, Faker |
| Deployment | Docker, Kamal, Thruster |

## 🗂 Domain Model

- **User** — has many books, one cart, and sends/receives messages. Authenticated via Devise.
- **Book** — belongs to a user (the seller/author); has a cover image and book file attachment; tracks `total_purchases`.
- **Cart** — belongs to a user; has many line items; calculates a total price.
- **LineItem** — belongs to both a cart and a book; represents a book + quantity + price in a cart.
- **Message** — belongs to a sender (user) and has a recipient, used for direct chat.
- **AdminUser** — separate Devise-authenticated model for Active Admin access.

## 🚀 Getting Started

### Prerequisites

- Ruby 3.4.1
- Bundler
- SQLite3
- Node/Yarn (for asset-related tooling, if needed)
- A Stripe account (for payment features)

### Installation

```bash
# Clone the repo
git clone https://github.com/Saurabhkr001/Bookify-Rails.git
cd Bookify-Rails

# Install Ruby dependencies
bundle install
```

### Environment Variables

Create a `.env` file in the project root (loaded via `dotenv-rails` in development/test) with at least:

```
STRIPE_SECRET_KEY=sk_test_xxxxxxxxxxxx
GMAIL_USERNAME=your_email@gmail.com
GMAIL_APP_PASSWORD=your_app_password
```

### Database Setup

```bash
rails db:create
rails db:migrate
rails db:seed
```

> The seed file creates a default Active Admin user in development (`admin@example.com` / `password`).

### Running the App

```bash
rails server
# or, to run the server alongside Sidekiq/Tailwind-style watchers:
bin/dev
```

Visit `http://localhost:3000`.

To use background jobs (chat broadcasting, etc.), make sure Redis is running and start Sidekiq:

```bash
bundle exec sidekiq
```

The Sidekiq web UI is available at `/sidekiq` for authenticated admin users.

### Admin Panel

Active Admin is available at `/admin`. Log in with the seeded admin credentials in development.

## 🧪 Running Tests

```bash
# RSpec suite (models, requests, helpers, views)
bundle exec rspec

# Minitest / system tests
rails test
rails test:system
```

## 📁 Project Structure

```
app/
  controllers/   # Books, Carts, LineItems, Messages, Payments, Users
  models/        # User, Book, Cart, LineItem, Message, AdminUser
  policies/      # Pundit authorization policies
  jobs/          # Background jobs (e.g., message broadcasting)
  channels/      # Action Cable channels for real-time chat
  mailers/       # Email notifications
  admin/         # Active Admin resource configurations
  views/         # ERB templates
config/
  routes.rb      # Application routes
  database.yml   # Database configuration
db/
  migrate/       # Schema migrations
  schema.rb      # Current database schema
  seeds.rb       # Seed data
spec/ & test/    # RSpec and Minitest test suites
```

## 🗺 Key Routes

| Route | Description |
|---|---|
| `/` | Book listing (home page) |
| `/books/:id` | Book details |
| `/books/new`, `/books/:id/edit` | Publish / edit a book |
| `/books/:id/buy` | Purchase a book directly |
| `/cart` | View shopping cart |
| `/line_items` | Add/update/remove items in cart |
| `/payments` | Stripe checkout session creation |
| `/success`, `/cancel` | Payment result pages |
| `/users/:id` | User profile / chat with a user |
| `/admin` | Active Admin dashboard |
| `/sidekiq` | Sidekiq job monitoring (admin-only) |

## 🚢 Deployment

The app includes a `Dockerfile` and Kamal configuration (`.kamal/`, `config/deploy.yml`) for container-based deployment.

```bash
# Build and push with Kamal
kamal setup
kamal deploy
```

Alternatively, deploy to any platform supporting Ruby on Rails + PostgreSQL, ensuring the environment variables above are configured.
