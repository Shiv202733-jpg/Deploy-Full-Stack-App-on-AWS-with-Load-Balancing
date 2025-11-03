const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Simple in-memory todo list (no DB for demo)
let todos = [
  { id: 1, title: "Learn AWS EC2", completed: false },
  { id: 2, title: "Set up ALB", completed: false },
];

// Routes
app.get('/', (req, res) => {
  res.send('Backend is running on EC2 behind ALB!');
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

// CRUD routes
app.get('/api/todos', (req, res) => {
  res.json(todos);
});

app.post('/api/todos', (req, res) => {
  const newTodo = { id: Date.now(), title: req.body.title, completed: false };
  todos.push(newTodo);
  res.status(201).json(newTodo);
});

app.put('/api/todos/:id', (req, res) => {
  const todo = todos.find(t => t.id == req.params.id);
  if (!todo) return res.status(404).send('Todo not found');
  todo.completed = req.body.completed;
  res.json(todo);
});

app.delete('/api/todos/:id', (req, res) => {
  todos = todos.filter(t => t.id != req.params.id);
  res.status(204).send();
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server running on port ${PORT}`);
});
