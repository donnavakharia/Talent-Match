package com.adnan;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class View implements Comparable<View> {

	@Id private Long id;
	private String streamname;   //TODO: Verify
	private Date viewTime;


	@SuppressWarnings("unused")
	private View() {
	}

	public View(String stream_name, Date viewTime) {		
		this.streamname = stream_name;
		this.viewTime = viewTime;

	}

	@Override
	public int compareTo(View other) {
		if (viewTime.after(other.viewTime)) {
			return 1;
		} else if (viewTime.before(other.viewTime)) {
			return -1;
		}
		return 0;
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(id.toString(), streamname, viewTime.toString());
 	}

	public String getStreamViewId() {
		return id.toString();
	}

	public String getStreamName() {
		return this.streamname;
	}

	public Date getViewTime(){
		return this.viewTime;
	}
}