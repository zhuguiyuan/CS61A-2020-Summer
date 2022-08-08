class Student:
    students = 0
    def __init__(self, name, ta):
        self.name = name
        self.understanding = 0
        Student.students += 1
        print("There are now", Student.students, "students")
        ta.add_student(self)
    
    def visit_office_hours(self, staff):
        staff.assist(self)
        print("Thanks, " + staff.name)

class Professor:
    def __init__(self, name):
        self.name = name
        self.students = {}
    
    def add_student(self, student):
        self.students[student.name] = student
    
    def assist(self, student):
        student.understanding += 1