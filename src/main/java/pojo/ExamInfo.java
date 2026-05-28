package pojo;

import java.util.Date;

public class ExamInfo {
    private int studentId;
    private  int paperId;
    private int isTested=-1;
    private int isRead=-1;
    private String teacherName;
    private String paperName;
    private String studentName;
    private int score;
    private String rocord;
    private Date startTime;
    private int paperTime;

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public int getPaperTime() {
        return paperTime;
    }

    public void setPaperTime(int paperTime) {
        this.paperTime = paperTime;
    }

    public String getRocord() {
        return rocord;
    }

    public void setRocord(String rocord) {
        this.rocord = rocord;
    }

    public String getPaperName() {
        return paperName;
    }

    public void setPaperName(String paperName) {
        this.paperName = paperName;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getPaperId() {
        return paperId;
    }

    public void setPaperId(int paperId) {
        this.paperId = paperId;
    }

    public int getIsTested() {
        return isTested;
    }

    public void setIsTested(int isTested) {
        this.isTested = isTested;
    }

    public int getIsRead() {
        return isRead;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }
}
