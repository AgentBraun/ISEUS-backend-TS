/*
  Warnings:

  - Added the required column `subjectID` to the `subjectActivity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subjectID` to the `Exam` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "JoinStudentExam" (
    "studentID" INTEGER NOT NULL,
    "examID" INTEGER NOT NULL,

    PRIMARY KEY ("studentID", "examID"),
    CONSTRAINT "JoinStudentExam_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinStudentExam_examID_fkey" FOREIGN KEY ("examID") REFERENCES "Exam" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinStudentPartialExam" (
    "studentID" INTEGER NOT NULL,
    "partialExamID" INTEGER NOT NULL,

    PRIMARY KEY ("studentID", "partialExamID"),
    CONSTRAINT "JoinStudentPartialExam_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinStudentPartialExam_partialExamID_fkey" FOREIGN KEY ("partialExamID") REFERENCES "PartialExam" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinStudentSubjectActivities" (
    "studentID" INTEGER NOT NULL,
    "subjectActivitiesID" INTEGER NOT NULL,

    PRIMARY KEY ("studentID", "subjectActivitiesID"),
    CONSTRAINT "JoinStudentSubjectActivities_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinStudentSubjectActivities_subjectActivitiesID_fkey" FOREIGN KEY ("subjectActivitiesID") REFERENCES "subjectActivity" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinProfessorExam" (
    "professorID" INTEGER NOT NULL,
    "examID" INTEGER NOT NULL,

    PRIMARY KEY ("professorID", "examID"),
    CONSTRAINT "JoinProfessorExam_professorID_fkey" FOREIGN KEY ("professorID") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinProfessorExam_examID_fkey" FOREIGN KEY ("examID") REFERENCES "Exam" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "JoinAsistentExam" (
    "asistentID" INTEGER NOT NULL,
    "examID" INTEGER NOT NULL,

    PRIMARY KEY ("asistentID", "examID"),
    CONSTRAINT "JoinAsistentExam_asistentID_fkey" FOREIGN KEY ("asistentID") REFERENCES "Asistent" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "JoinAsistentExam_examID_fkey" FOREIGN KEY ("examID") REFERENCES "Exam" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_subjectActivity" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "deadline" DATETIME NOT NULL,
    "score" INTEGER NOT NULL,
    "dificultyFactor" INTEGER NOT NULL,
    "subjectID" INTEGER NOT NULL,
    CONSTRAINT "subjectActivity_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_subjectActivity" ("deadline", "dificultyFactor", "id", "name", "score", "type") SELECT "deadline", "dificultyFactor", "id", "name", "score", "type" FROM "subjectActivity";
DROP TABLE "subjectActivity";
ALTER TABLE "new_subjectActivity" RENAME TO "subjectActivity";
CREATE TABLE "new_Exam" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "examCondition" TEXT NOT NULL,
    "dificultyFactor" INTEGER NOT NULL,
    "subjectID" INTEGER NOT NULL,
    CONSTRAINT "Exam_subjectID_fkey" FOREIGN KEY ("subjectID") REFERENCES "Subject" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Exam" ("date", "dificultyFactor", "examCondition", "id", "name", "type") SELECT "date", "dificultyFactor", "examCondition", "id", "name", "type" FROM "Exam";
DROP TABLE "Exam";
ALTER TABLE "new_Exam" RENAME TO "Exam";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
