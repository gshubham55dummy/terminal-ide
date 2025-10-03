/**
 * Home Route
 * Handles routing for the home page of the application
 */

// Import Express framework
var express = require('express');

// Create a new router instance
var router = express.Router();

/**
 * GET home page route
 * @route GET /
 * @returns {View} Renders the index view with the title
 */
router.get('/', function(req, res, next) {
  // Render the index template and pass the title variable
  res.render('index', { title: 'Visual Studio Code!' });
});

// Export the router to be used in the main application
module.exports = router;
