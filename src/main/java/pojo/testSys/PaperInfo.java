package pojo.testSys;

import java.util.Date;

public class PaperInfo {
    private int paperid;
    private String paperName;
    private int userid;
    private Date startTime;
    private Date endTime;
    private int paperTime;
    private int score;
    private Date paperStart;
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getPaperStart() {
        return paperStart;
    }

    public void setPaperStart(Date paperStart) {
        this.paperStart = paperStart;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getPaperid() {
        return paperid;
    }

    public void setPaperid(int paperid) {
        this.paperid = paperid;
    }

    public String getPaperName() {
        return paperName;
    }

    public void setPaperName(String paperName) {
        this.paperName = paperName;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getPaperTime() {
        return paperTime;
    }

    public void setPaperTime(int paperTime) {
        this.paperTime = paperTime;
    }
}
