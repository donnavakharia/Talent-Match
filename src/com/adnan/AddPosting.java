package com.adnan;

import java.util.Date;
import java.util.Hashtable;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyFactory;

@Entity
public class AddPosting implements Comparable<AddPosting> {

	static {
		 ObjectifyService.register(AddPosting.class);
	}
	// id is set by the datastore for us
	@Id
	public Long id;
	
	public Date createDate;
	
	public int viewCount;
	private int view;
	public int totalClicks;
	public Long[] timeClicked = new Long[1000];
		public String jobID;
	public String title;
	public String category;
	public String location;
	public String skills;
	public String experience;
	public String hiringManager;
	public String hiringManagerEmail;
	public String postOwner;
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private AddPosting() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(id.toString(), jobID, title, category, location, skills, experience, createDate.toString());
 	}

	//public AddPosting(String name, String tags, String s, String m, String coverImageUrl, String streamOwner) {
	public AddPosting(String owner, String ID, String title, String category, String location, String skills, String experience, String manager, String email) {
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
		this.jobID=ID;
		this.title=title;
		this.category=category;
		this.location=location;
		this.createDate = new Date();
		this.skills=skills;
		this.experience=experience;
		this.hiringManager=manager;
		this.hiringManagerEmail=email;
		
	}

	@Override
	public int compareTo(AddPosting other) {
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
