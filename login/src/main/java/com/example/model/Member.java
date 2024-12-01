package com.example.model;
public class Member {
	private String uname, password, email, first_name, last_name, userType;

	public Member() {
		super();
	}

	public Member(String uname, String password, String email, String first_name, String last_name, String userType) {
		super();
		this.uname = uname;
		this.password = password;
		this.email = email;
		this.first_name = first_name;
		this.last_name = last_name;
		this.userType = userType;
	}
	
	public Member(String uname, String password, String userType) {
		super();
		this.uname = uname;
		this.password = password;
		this.userType = userType;
	}
	
	// Constructor for login without user type
    public Member(String uname, String password) {
        super();
        this.uname = uname;
        this.password = password;
    }

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setFirstName(String first_name) {
		this.first_name = first_name;
	}
	
	public String getFirstName() {
		return first_name;
	}
	
	public void setLastName(String last_name) {
		this.last_name = last_name;
	}
	
	public String getLastName() {
		return last_name;
	}
	
	public String getUserType() {
	    return userType;
	}

	public void setUserType(String userType) {
	    this.userType = userType;
	}

}