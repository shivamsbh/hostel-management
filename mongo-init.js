// MongoDB initialization script
// This script runs when MongoDB container starts for the first time

// Switch to the hostel database
db = db.getSiblingDB('hostel');

// Create a user for the hostel database
db.createUser({
  user: 'hostel_user',
  pwd: 'hostel_password',
  roles: [
    {
      role: 'readWrite',
      db: 'hostel'
    }
  ]
});

// Create initial collections if needed
db.createCollection('users');
db.createCollection('complaints');
db.createCollection('announcements');

print('Database initialized successfully');