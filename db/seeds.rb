require_relative "../models"

john = User.create!(name: "John")
peter = User.create!(name: "Peter")

SourceCode.create!(user: john, points: 45, status: SourceCode::DONE)
SourceCode.create!(user: john, points: 20, status: SourceCode::DONE)
SourceCode.create!(user: peter, points: 20, status: SourceCode::DONE)
SourceCode.create!(user: peter, points: 30, status: SourceCode::DONE)
