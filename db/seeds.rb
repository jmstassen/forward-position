john = User.create(name: "John", email: "john@john.com", password: "password")
long = User.create(name: "Long", email: "long@long.com", password: "password")

task1 = Task.create(name: "Approve timecards", due_date: "2020-02-20", do_date: "2020-02-19", category: "approval", size: "5", status: "active", user_id: john.id)
task2 = Task.create(name: "Email Heather", due_date: "2020-01-24", do_date: "2020-01-24", category: "email", size: "3", status: "active", user_id: john.id)
task3 = Task.create(name: "New business cards", due_date: "2020-01-30", do_date: "2020-01-25", category: "deliverable", size: "3", status: "active", user_id: long.id)

note1 = Note.create(content: "Remind her about something", task_id: task2.id, status: "open", user_id: long.id)
note2 = Note.create(content: "Look at calendar", task_id: task2.id, status: "open", user_id: long.id)
note3 = Note.create(content: "Email procurement", task_id: task3.id, status: "closed", user_id: john.id)
note4 = Note.create(content: "Finalize titles", task_id: task3.id, status: "closed", user_id: john.id)
note5 = Note.create(content: "How many?", task_id: task3.id, status: "open", user_id: long.id)
note6 = Note.create(content: "Check for 9999", task_id: task1.id, status: "open", user_id: john.id)
