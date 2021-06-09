package models;

public class User {
	public final String username;
	public final UserType type;
	public final String name;

	public User(String username, String name, UserType type) {
		this.username = username;
		this.name = name;
		this.type = type;
	}

	@Override
	public String toString() {
		return this.username;
	}
}
