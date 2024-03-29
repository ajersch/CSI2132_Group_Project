package backend;

public class Employee {
    private int sin;
    private String firstName;
    private String lastName;
    private int streetNumber;
    private String streetName;
    private String city;
    private String country;
    private boolean archived;

    public Employee(int sin, String firstName, String lastName, int streetNumber, String streetName, String city, String country, boolean archived) {
        this.sin = sin;
        this.firstName = firstName;
        this.lastName = lastName;
        this.streetNumber = streetNumber;
        this.streetName = streetName;
        this.city = city;
        this.country = country;
        this.archived = archived;
    }

    //getters
    public int getSin() {
        return sin;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
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

    public boolean isArchived() {
        return archived;
    }

    //setters
    public void setSin(int sin) {
        this.sin = sin;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setStreetNumber(int streetNumber) {
        this.streetNumber = streetNumber;
    }

    public void setStreet(String streetName) {
        this.streetName = streetName;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setArchived(boolean archived) {
        this.archived = archived;
    }
}
