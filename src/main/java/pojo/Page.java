package pojo;


import java.util.List;

public class Page<E> {

    public static final String PAGE_START="select * from ( SELECT a.*, rownum rn  FROM (";
    public static final String PAGE_END=") a WHERE rownum <= ?) b where b.rn > ?";

    /**
     * 查询条件
     */
    private E condition;

    //总记录数
    private Long total;

    //当前页
    private Integer currentPage = 1;

    //每页数量
    private Integer pageSize = 10;

    //总页数
    public Integer getTotalPage() {
        return (int) Math.ceil(total*1.0 / pageSize);
    }

    public Integer getStart(){
        return (currentPage-1)*pageSize;
    }

    public Integer getEnd(){
        return currentPage*pageSize;
    }

    //结果集合
    private List<E> list;

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public void setCurrentPage(String currentPage) {
        if(currentPage!=null){
            try{
                this.currentPage = Integer.valueOf(currentPage);
            }catch (Exception e){
                System.out.print("分页参数不正确");
            }
        }
    }

    public E getCondition() {
        return condition;
    }

    public void setCondition(E condition) {
        this.condition = condition;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public List<E> getList() {
        return list;
    }

    public void setList(List<E> list) {
        this.list = list;
    }
}

