package com.adnan;

import java.util.Date;
import java.util.Hashtable;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyFactory;

@Entity
public class JobSeeker implements Comparable<JobSeeker> {

	static {
		 ObjectifyService.register(JobSeeker.class);
	}
	// id is set by the datastore for us
	@Id
	public Long id;
	
	public Date createDate;
	
	public int viewCount;
	private int view;
	public int totalClicks;
	public Long[] timeClicked = new Long[1000];
		
	public String seekerID;
	public String firstname;
	public String lastname;
	public String zipcode;
	public String city;
	public String state;
	public String country;
	public String interests;
	public String jobtype;
	public String postOwner;
	public String email;
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private JobSeeker() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(id.toString(), seekerID, firstname, lastname, zipcode, city, state, country, interests, jobtype, createDate.toString());
 	}

	//public AddPosting(String name, String tags, String s, String m, String coverImageUrl, String streamOwner) {
	public JobSeeker(String owner, String ID, String firstname, String lastname, String zipcode, String city, String state, String country, String interests, String jobtype, String email) {
		/*this.name = name;
		this.tags = tags;
		this.subscribers = s;
		this.message = m;
		this.coverImageUrl = coverImageUrl;
		this.createDate = new Date();
		this.viewCount=0;
		this.totalClicks=0;
		this.streamOwner = streamOwner;
		this.view=0;*/
		
		this.postOwner=owner;
		this.seekerID=ID;
		this.firstname=firstname;
		this.lastname=lastname;
		this.zipcode=zipcode;
		this.createDate = new Date();
		this.city=city;
		this.state=state;
		this.country=country;
		this.interests=interests;
		this.jobtype=jobtype;
		this.email=email;
		
	}

	@Override
	public int compareTo(JobSeeker other) {
		if (createDate.after(other.createDate)) {
			return 1;
		} else if (createDate.before(other.createDate)) {
			return -1;
		}
		return 0;
	}
	
	public int getViewCount() {
		return view;
	}
}
