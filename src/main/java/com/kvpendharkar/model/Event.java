package com.kvpendharkar.model;

import java.time.LocalDateTime;

public class Event {
  private Long id;
  private String title;
  private String description;
  private LocalDateTime datetime;
  private String location;
  private Integer seats;
  private Integer registeredCount;
  // getters & setters
  public Long getId(){return id;} public void setId(Long id){this.id=id;}
  public String getTitle(){return title;} public void setTitle(String t){this.title=t;}
  public String getDescription(){return description;} public void setDescription(String d){this.description=d;}
  public LocalDateTime getDatetime(){return datetime;} public void setDatetime(LocalDateTime dt){this.datetime=dt;}
  public String getLocation(){return location;} public void setLocation(String l){this.location=l;}
  public Integer getSeats(){return seats;} public void setSeats(Integer s){this.seats=s;}
  public Integer getRegisteredCount(){return registeredCount;} public void setRegisteredCount(Integer r){this.registeredCount=r;}
}
