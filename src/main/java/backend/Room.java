package backend;

public class Room {
    private int roomId;
    private int hotelId;
    private float price;
    private int capacity;
    private boolean extendable;
    private int roomNumber;
    private boolean archived;

    //constructor for inserting into the database
    public Room(int hotelId, float price, int capacity, boolean extendable, int roomNumber) {
        this.roomId = -1;
        this.hotelId = hotelId;
        this.price = price;
        this.capacity = capacity;
        this.extendable = extendable;
        this.roomNumber = roomNumber;
        this.archived = false;
    }

    public Room(int roomId, int hotelId, float price, int capacity, boolean extendable, int roomNumber, boolean archived) {
        this.roomId = roomId;
        this.hotelId = hotelId;
        this.price = price;
        this.capacity = capacity;
        this.extendable = extendable;
        this.roomNumber = roomNumber;
        this.archived = archived;
    }

    //getters
    public int getRoomId() {
        return roomId;
    }

    public int getHotelId() {
        return hotelId;
    }

    public float getPrice() {
        return price;
    }

    public int getCapacity() {
        return capacity;
    }

    public boolean isExtendable() {
        return extendable;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public boolean isArchived() {
        return archived;
    }

    //setters
    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public void setHotelId(int hotelId) {
        this.hotelId = hotelId;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public void setExtendable(boolean extendable) {
        this.extendable = extendable;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public void setArchived(boolean archived) {
        this.archived = archived;
    }
}
