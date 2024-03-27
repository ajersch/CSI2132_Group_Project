package backend;

public class Chain {
    private int streetNumber;
    private String streetName;
    private String city;
    private String country;
    private String name;
    private boolean archived;

    //constructor for insertion into the database
    public Chain(int streetNumber, String streetName, String city, String country, String name) {
        this.streetNumber = streetNumber;
        this.streetName = streetName;
        this.city = city;
        this.country = country;
        this.name = name;
        this.archived = false;
    }

    public Chain(int streetNumber, String streetName, String city, String country, String name, boolean archived) {
        this.streetNumber = streetNumber;
        this.streetName = streetName;
        this.city = city;
        this.country = country;
        this.name = name;
        this.archived = archived;
    }

    //getters
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

    public String getName() {
        return name;
    }

    public boolean isArchived() {
        return archived;
    }

    //setters
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

    public void setName(String name) {
        this.name = name;
    }

    public void setArchived(boolean archived) {
        this.archived = archived;
    }
}
