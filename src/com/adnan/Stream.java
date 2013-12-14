package com.adnan;

import java.util.Date;
import java.util.Hashtable;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyFactory;

@Entity
public class Stream implements Comparable<Stream> {

	static {
		 ObjectifyService.register(Stream.class);
	}
	// id is set by the datastore for us
	@Id
	public Long id;
	public String name;
	public String tags;
	public String subscribers;
	public String message="hi";
	public Date createDate;
	public String coverImageUrl;
	public int viewCount;
	private int view;
	public int totalClicks;
	public Long[] timeClicked = new Long[1000];
	public String streamOwner;
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private Stream() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(id.toString(), name, tags, createDate.toString());
 	}

	public Stream(String name, String tags, String s, String m, String coverImageUrl, String streamOwner) {
		this.name = name;
		this.tags = tags;
		this.subscribers = s;
		this.message = m;
		this.coverImageUrl = coverImageUrl;
		this.createDate = new Date();
		this.viewCount=0;
		this.totalClicks=0;
		this.streamOwner = streamOwner;
		this.view=0;
	}

	@Override
	public int compareTo(Stream other) {
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
