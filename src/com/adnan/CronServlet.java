package com.adnan;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Collections;

import com.adnan.*;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class CronServlet extends HttpServlet {
	static {
		ObjectifyService.register(View.class);
		ObjectifyService.register(LeaderShipEntity.class);
	}
	
	private static HashMap<String, Integer> sortByComparator(
			Map<String, Integer> unsortMap, final boolean order) {

		List<Entry<String, Integer>> list = new LinkedList<Entry<String, Integer>>(
				unsortMap.entrySet());

		Collections.sort(list, new Comparator<Entry<String, Integer>>() {
			public int compare(Entry<String, Integer> val1,
					Entry<String, Integer> val2) {
				if (order) {
					return val1.getValue().compareTo(val2.getValue());
				} else {
					return val2.getValue().compareTo(val1.getValue());

				}
			}
		});
		
		HashMap<String, Integer> sortedMap = new LinkedHashMap<String, Integer>();
		for (Entry<String, Integer> entry : list) {
			sortedMap.put(entry.getKey(), entry.getValue());
		}

		return sortedMap;
	}

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		List<View> viewList = ofy().load().type(View.class).list();
		HashMap<String, Integer> viewMap = new HashMap<String, Integer>();

		Date currentTime = new Date();
		
		if (!viewList.isEmpty()) {
			
			for (View view : viewList) {

				String hashkey = view.getStreamName();
				if (viewMap.containsKey(hashkey)) {
					int diff = (int) ((currentTime.getTime() - view
							.getViewTime().getTime()) / 1000) / 60;
					
					if (diff <= 60) {
						Integer tempval = viewMap.get(hashkey);
						tempval = tempval + 1;
						viewMap.put(hashkey, tempval);
					}
				} else {
					viewMap.put(hashkey, 0);
				}

			}
		}
		
		HashMap<String, Integer> sortedMap = sortByComparator(viewMap,
				false);
		Iterator it = sortedMap.entrySet().iterator();
		int count = 0;
		
		String[] s = new String[3];
		int[] c = new int[3];
		List<String> trendingStreams = new ArrayList<String>();
		List<Integer> viewCnt = new ArrayList<Integer>();
		while (it.hasNext() && count <= 2) {
			Map.Entry pairs = (Map.Entry) it.next();
			
			trendingStreams.add(pairs.getKey().toString());
			viewCnt.add(Integer.parseInt(pairs.getValue().toString()));
			count++;
		}
		if (trendingStreams.size() > 2) {
		}

		for(int i=0; i<3; i++) {
			s[i]=trendingStreams.get(i);
			c[i]=viewCnt.get(i);
		}
		
		List<LeaderShipEntity> top = OfyService.ofy().load()
				.type(LeaderShipEntity.class).list();
		
		for(LeaderShipEntity le : top) {
				ofy().delete().entity(le);
		}
		
		
		LeaderShipEntity l = new LeaderShipEntity(s[0],s[1],s[2],c[0],c[1],c[2]);
		ofy().save().entity(l).now();
		

	}

	
}

