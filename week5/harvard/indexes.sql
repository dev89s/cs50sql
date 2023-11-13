CREATE INDEX "student_index" ON "enrollments" ("student_id", "course_id");

CREATE INDEX "course_index" ON "enrollments" ("course_id", "student_id");

CREATE INDEX "semester_department_index" ON "courses" ("semester", "department");

CREATE INDEX "satisfies_index" ON "satisfies" ("course_id","requirement_id");
