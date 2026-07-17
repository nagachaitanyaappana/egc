package com.example.demo.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "villages")
public class Village {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String name;

    @Column(length = 200)
    private String district;

    @OneToMany(mappedBy = "village", cascade = CascadeType.ALL)
    private List<User> users = new ArrayList<>();

    public Village() {}

    public Village(String name, String district) {
        this.name = name;
        this.district = district;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public List<User> getUsers() { return users; }
    public void setUsers(List<User> users) { this.users = users; }
}
