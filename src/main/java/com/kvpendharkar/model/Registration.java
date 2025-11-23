package com.kvpendharkar.model;

import java.time.LocalDateTime;

public class Registration {
  private Long id;
  private Long eventId;
  private String name;
  private String email;
  private String phone;
  private String remarks;
  private LocalDateTime createdAt = LocalDateTime.now();
  // getters & setters
  public Long getId(){return id;} public void setId(Long id){this.id=id;}
  public Long getEventId(){return eventId;} public void setEventId(Long e){this.eventId=e;}
  public String getName(){return name;} public void setName(String n){this.name=n;}
  public String getEmail(){return email;} public void setEmail(String e){this.email=e;}
  public String getPhone(){return phone;} public void setPhone(String p){this.phone=p;}
  public String getRemarks(){return remarks;} public void setRemarks(String r){this.remarks=r;}
  public java.time.LocalDateTime getCreatedAt(){return createdAt;} public void setCreatedAt(java.time.LocalDateTime c){this.createdAt=c;}
}
