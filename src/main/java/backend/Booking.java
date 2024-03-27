package backend;

public class Booking {
    private int roomId;
    private String startDate;
    private String endDate;
    private int customerSin;

    public Booking(int roomId, String startDate, String endDate, int customerSin) {
        this.roomId = roomId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.customerSin = customerSin;
    }

    //getters
    public int getRoomId() {
        return roomId;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public int getCustomerSin() {
        return customerSin;
    }

    //setters
    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public void setCustomerSin(int customerSin) {
        this.customerSin = customerSin;
    }
}
