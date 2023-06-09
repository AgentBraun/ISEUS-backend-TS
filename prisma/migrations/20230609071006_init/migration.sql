-- CreateTable
CREATE TABLE "Admin" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "University" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "shortName" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Faculty" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "universityID" INTEGER NOT NULL,
    CONSTRAINT "Faculty_universityID_fkey" FOREIGN KEY ("universityID") REFERENCES "University" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StudyProgram" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "facultyID" INTEGER NOT NULL,
    CONSTRAINT "StudyProgram_facultyID_fkey" FOREIGN KEY ("facultyID") REFERENCES "Faculty" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Subject" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "ECTSpoints" INTEGER NOT NULL,
    "semester" INTEGER NOT NULL,
    "QRCode" TEXT NOT NULL,
    "studyProgramID" INTEGER NOT NULL,
    CONSTRAINT "Subject_studyProgramID_fkey" FOREIGN KEY ("studyProgramID") REFERENCES "StudyProgram" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Lecture" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "subjectID" INTEGER NOT NULL,
    CONSTRAINT "Lecture_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Exercise" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "subjectID" INTEGER NOT NULL,
    CONSTRAINT "Exercise_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Attendance" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "presence" BOOLEAN NOT NULL,
    "date" DATETIME NOT NULL,
    "QRCode" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "hoursNumber" INTEGER NOT NULL,
    "studentID" INTEGER NOT NULL,
    "lectureID" INTEGER NOT NULL,
    "exerciseID" INTEGER NOT NULL,
    CONSTRAINT "Attendance_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Attendance_lectureID_fkey" FOREIGN KEY ("lectureID") REFERENCES "Lecture" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Attendance_exerciseID_fkey" FOREIGN KEY ("exerciseID") REFERENCES "Exercise" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Student" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "indexNumber" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "studyYear" INTEGER NOT NULL,
    "profileImage" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "repeater" BOOLEAN NOT NULL,
    "signature" BOOLEAN NOT NULL,
    "studyProgramID" INTEGER NOT NULL,
    CONSTRAINT "Student_studyProgramID_fkey" FOREIGN KEY ("studyProgramID") REFERENCES "StudyProgram" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinStudentSubject" (
    "studentID" INTEGER NOT NULL,
    "subjectID" INTEGER NOT NULL,
    "approved" BOOLEAN NOT NULL,

    PRIMARY KEY ("studentID", "subjectID"),
    CONSTRAINT "JoinStudentSubject_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinStudentSubject_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Exam" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "examCondition" TEXT NOT NULL,
    "dificultyFactor" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "PartialExam" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "examCondition" TEXT NOT NULL,
    "dificultyFactor" INTEGER NOT NULL,
    "examID" INTEGER NOT NULL,
    CONSTRAINT "PartialExam_examID_fkey" FOREIGN KEY ("examID") REFERENCES "Exam" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Professor" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "profileImage" TEXT NOT NULL,
    "approved" BOOLEAN NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "JoinProfessorSubject" (
    "professorID" INTEGER NOT NULL,
    "subjectID" INTEGER NOT NULL,
    "approved" BOOLEAN NOT NULL,

    PRIMARY KEY ("professorID", "subjectID"),
    CONSTRAINT "JoinProfessorSubject_professorID_fkey" FOREIGN KEY ("professorID") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinProfessorSubject_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinProfessorLecture" (
    "professorID" INTEGER NOT NULL,
    "lectureID" INTEGER NOT NULL,
    "approved" BOOLEAN NOT NULL,

    PRIMARY KEY ("professorID", "lectureID"),
    CONSTRAINT "JoinProfessorLecture_professorID_fkey" FOREIGN KEY ("professorID") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinProfessorLecture_lectureID_fkey" FOREIGN KEY ("lectureID") REFERENCES "Lecture" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Asistent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "profileImage" TEXT NOT NULL,
    "approved" BOOLEAN NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "JoinAsistentSubject" (
    "asistentID" INTEGER NOT NULL,
    "subjectID" INTEGER NOT NULL,
    "approved" BOOLEAN NOT NULL,

    PRIMARY KEY ("asistentID", "subjectID"),
    CONSTRAINT "JoinAsistentSubject_asistentID_fkey" FOREIGN KEY ("asistentID") REFERENCES "Asistent" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinAsistentSubject_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinAsistentExercise" (
    "asistentID" INTEGER NOT NULL,
    "exerciseID" INTEGER NOT NULL,
    "approved" BOOLEAN NOT NULL,

    PRIMARY KEY ("asistentID", "exerciseID"),
    CONSTRAINT "JoinAsistentExercise_asistentID_fkey" FOREIGN KEY ("asistentID") REFERENCES "Asistent" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinAsistentExercise_exerciseID_fkey" FOREIGN KEY ("exerciseID") REFERENCES "Exercise" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "subjectActivity" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "deadline" DATETIME NOT NULL,
    "score" INTEGER NOT NULL,
    "dificultyFactor" INTEGER NOT NULL
);
