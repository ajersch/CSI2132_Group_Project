package backend;

public class Hotel {
    private int id;
    private int streetNumber;
    private String streetName;
    private String city;
    private String country;
    private String chainName;
    private String name;
    private int stars;
    private boolean archived;

    // constructor for inserting a hotel
    public Hotel(int streetNumber, String streetName, String city, String country, String chainName, String name, int stars) {
        this.id = -1;
        this.streetNumber = streetNumber;
        this.streetName = streetName;
        this.city = city;
        this.country = country;
        this.chainName = chainName;
        this.name = name;
        this.stars = stars;
        this.archived = false;
    }

    public Hotel(int id, int streetNumber, String streetName, String city, String country, String chainName, String name, int stars, boolean archived) {
        this.id = id;
        this.streetNumber = streetNumber;
        this.streetName = streetName;
        this.city = city;
        this.country = country;
        this.chainName = chainName;
        this.name = name;
        this.stars = stars;
        this.archived = archived;
    }

    //getters
    public int getId() {
        return id;
    }

    public int getStreetNumber() {
        return streetNumber;
    }

    public String getStreetName() {
        return streetName;
    }

    public String getCity() {
        return city;
    }

    public String getCountry() {
        return country;
    }

    public String getChainName() {
        return chainName;
    }

    public String getName() {
        return name;
    }

    public int getStars() {
        return stars;
    }

    public boolean isArchived() {
        return archived;
    }

    //setters
    public void setId(int id) {
        this.id = id;
    }

    public void setStreetNumber(int streetNumber) {
        this.streetNumber = streetNumber;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setChainName(String chainName) {
        this.chainName = chainName;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }

    public void setArchived(boolean archived) {
        this.archived = archived;
    }
}
