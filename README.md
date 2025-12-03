# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
#  Mini Helpdesk – Support Ticket System (Ruby on Rails 8)

Mini Helpdesk is a small but fully functional **Support Ticket System** built with **Ruby on Rails 8**.  
It lets users:

- Sign up / log in
- Create support tickets
- Attach screenshots/files
- Add comments on tickets
- Track status and priority of issues

It’s designed as a **learning project** for Ruby on Rails, but it follows **real-world patterns** (MVC, Devise, Active Storage, enums, Turbo) so it can be shown confidently in a portfolio or interview.

---

##  Table of Contents

1. [What This Project Is](#-what-this-project-is)
2. [High-Level Flow (10th-Grade Explanation)](#-high-level-flow-10th-grade-explanation)
3. [Features](#-features)
4. [Data Model & Relationships](#-data-model--relationships)
5. [Request Flow Example](#-request-flow-example)
6. [Installation & Setup](#-installation--setup)
7. [How to Use the App (Step-by-Step)](#-how-to-use-the-app-step-by-step)
8. [Important Files & Folders](#-important-files--folders)
9. [Possible Future Improvements](#-possible-future-improvements)
10. [Author](#-author)

---

##  What This Project Is

At a high level, this is a **mini customer support system** similar to what a company’s IT or customer-care team would use.

- A **user** logs in to the system.
- They can create a **ticket** describing a problem (e.g., “My ID is blocked”).
- They can attach **screenshots** or files to show the problem.
- Other users can reply with **comments** to discuss and resolve the issue.
- Tickets have **status** and **priority**, so it’s easy to track what is urgent and what is resolved.

Under the hood, it showcases:

- Ruby on Rails 8 (latest patterns, including new enum syntax)
- Devise for authentication
- Active Storage for file uploads
- Turbo Streams for updating comments without a full page reload
- Clean MVC structure (models, controllers, views)

---

##  High-Level Flow (10th-Grade Explanation)

Think of this app like a **notebook** for problems:

- Each page in the notebook is a **ticket**.
- People can write **comments** under that page to discuss the problem.
- The notebook keeps track of:
  - Who wrote the problem (owner)
  - What type of problem (category)
  - How serious it is (priority)
  - Whether it’s still open or solved (status)
- The app stores all this information in a **database**, shows it on web pages, and keeps everything organized.

From a user’s point of view:

1. Open the website.
2. Sign up / log in.
3. Create a new ticket when you have a problem.
4. Add comments or reply to others.
5. Mark the ticket as resolved when it’s fixed.

---

##  Features

###  Authentication (Devise)
- User registration (sign up)
- Login / logout
- Password encryption & validation
- Protected routes: you **must** be logged in to access tickets

###  Ticket Management
Each ticket has:

- `title` – short summary of the issue  
- `description` – detailed explanation  
- `category` – area of the issue (e.g., “login”, “billing”, etc.)  
- `status` – uses Rails enum:
  - `open`
  - `in_progress`
  - `resolved`
- `priority` – Rails enum:
  - `low`
  - `medium`
  - `high`
- `owner` – the user who created the ticket  
- `assigned_to` – optional user who is responsible for handling it  
- `attachments` – files/images uploaded through Active Storage

###  Comments System
- Each ticket can have many comments.
- Each comment is written by a **user** and belongs to a **ticket**.
- Comments show:
  - Who wrote it
  - The body of the message
- Turbo Stream is used so that the comments section updates smoothly.

###  File Uploads
- Implemented using **Active Storage**.
- Users can attach one or more files to a ticket (e.g., screenshots).
- Files are linked to the ticket and can be downloaded from the ticket page.

###  User Roles (Enums)
The `User` model has a `role` attribute:

- `customer` – default role (creates tickets)  
- `agent` – can help solve tickets  
- `admin` – can manage everything

This is implemented using Rails 8 enum syntax:

```ruby
enum :role, { customer: 0, agent: 1, admin: 2 }
