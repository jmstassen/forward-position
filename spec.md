# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - built using Sinatra
- [x] Use ActiveRecord for storing information in a database - using ActiveRecord
- [x] Include more than one model class (e.g. User, Post, Category) - User, Task, Note, Reference
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) User has_many Tasks, Task has_many Notes, User has_many References
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) Task belongs_to User, Note belongs_to Task, Reference belongs_to User
- [x] Include user accounts with unique login attribute (username or email) - looking for unique email
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Tasks and resources both have CRUD routes
- [x] Ensure that users can't modify content created by other users - this is the case by default, though there is the ability to assign an assistant who will have access to your content
- [x] Include user input validations - Task names must not be empty, same with Reference titles. A user must have a non-empty name, email, and password
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - used flash messages to display signup errors
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message