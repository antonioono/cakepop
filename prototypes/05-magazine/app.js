// document.ontouchstart = function(e){ 
// 	e.preventDefault(); 
// }

var p = PSD;

/// GLOBALS ///

var cell			= 24,
	statusBarHeight = 36,
	height 			= 1136,
	width			= 640,
	curve			= "spring(250, 40, 500)",
	threshhold		= 50,
	parcelOpen		= false;


/// RENDER ///

setTimeout(function() {
	render();
}, 500)

p["Content"].opacity = 0;

function render() {
	p["Content"].opacity = 1;
	for (var i in p["Content"].subViews) { // Loop through bundles
		var parcel			= p["Content"].subViews[i],
			stories			= parcel.subViews,
			coverStory 		= stories[stories.length-2].subViews[0],
			storyIsOpen		= false,
			storyX;	

		setupParcel				(parcel, stories, coverStory, i);
		bindParcelEvents		(parcel, stories, coverStory, i);
		for (var j in stories) {
			var story = stories[j];
			setupStory		(stories, story, j)
			bindStoryEvents	(parcel, stories, coverStory, i, story, j);			
		}
		
	}
}

function setupParcel(parcel, stories, coverStory, i) {
	var multiple	= i+1,
		parcelY		= (height / p["Content"].subViews.length) * multiple,
		parcelX		= (width  / p["Content"].subViews.length) * i,
		title		= coverStory.subViews[1].subViews[1];
	
	// Set initial parcel position
	parcel.x		= width + (width/4) * Math.abs(stories.length - multiple*2);
	
	animateInFromRight();
	// animateInFromBottom();
	
	console.log(parcelX);
		
	function animateInFromRight() {
		// Animate in bundles
		parcel.animate({
			properties: {
				x:  parcelX+20
			},
			curve: "spring(250, 40, 100)"
		});
	}
	
	function animateInFromBottom() {
		parcel.x = parcelX;
		parcel.y = parcelY;
		
// 		Animate in bundles
		parcel.animate({
			properties: {
				y:  0
			},
			curve: curve
		});
	}
}

function bindParcelEvents(parcel, stories, coverStory, i) {
	parcel.on("click", function(){
		
		if (!parcelOpen) {
			openParcel();
			hideOtherParcels();
			parcelOpen = true;
		}
		
// 		Slide parcel to left
		function openParcel() {
			parcel.animate({
				properties: {
					x: 20
				},
				curve: "spring(250, 40, 200)"
			});
			for (var k in stories) {
				layoutStories(k);
				
			}
		}
		
		function hideOtherParcels() {
 // 		Hide other bundles
			for (var j in p["Content"].subViews) {
 // 			If not the current bundle
				if (j != parseInt(i)) {
					var otherParcel = p["Content"].subViews[j];
 // 				Animate to side
					otherParcel.animate({
						properties: {
						 	x: width+cell,
						 	y: 50
						},
						curve: "spring(400, 40, 20)"
					})
				}
			}
		 }
		
		function layoutStories(k) {
// 			If logo
			if (k > stories.length-2) {
				null;
// 			Else must be story
			} else {
				var story = stories[k]
				
// 				Animate in story
				animateInStory(story, k);
			}
		 }
		 
		 function animateInStory(story, k) {
//			Move stories to bottom
			if (k < stories.length-2) {
				story.y = height*2;
			}
			
// 			Slide to left
			// story.animate({
			// 	properties: {
			// 		x: 0,
			// 		y: 0
			// 	},
			// 	curve: "spring(200,30,700)"
			// });
			// 
// 			Spread out stories after they slide to left
			setTimeout(function(){
				story.animate({
				 	properties: {
				 		y: (statusBarHeight*3)+(k*256)-42
				 	},
					curve: "spring(200,30,700)"
				});
				 
//	   			Display titles; move to top
				animateInTitles(story, k);
//				Move logo to top
				moveParcelLogo(k)
			}, 666)
		 }
		 
		 function animateInTitles(story, k) {
			var title = story.subViews[1].subViews[1],
				titleAnimationMultiple = k;
			// title.animate({
			// 	properties: {
			// 		y: cell*1.5,
			// 		opacity: 1
			// 	},
			// 	curve: "spring(200,30,700)"
			// })
			setTimeout(function(){
				title.animate({
					properties: {
						y: cell*1.5,
						opacity: 1
					},
					curve: "spring(200,30,700)"
				})
			}, 50+(100*titleAnimationMultiple))
		 }
		 
		 function moveParcelLogo(k) {
		  	// 		Move logo
		  	stories[stories.length-1].animate({
		  		properties: {
		  			// opacity: 0
		  			scale: .333,
		  			y: statusBarHeight-12-42,
		  			x: width/7.5
		  			// x: -width/4.5
		  		},
		  		time: 300,
		  		curve: "spring(200,30,700)"
		  	});
		  }
	});	
}

function setupStory(stories, story, j) {
	if (j <= stories.length-2) {
	var title = story.subViews[1].subViews[1];
		title.opacity = 0;
	}
}

function bindStoryEvents(parcel, stories, coverStory, i, story, j) {
	story.on("click", function(){
// 		If logo
		if (j > stories.length-2) {
		} else {
			if (parcelOpen) {
				openStory(parcel, story, j);
				hideOtherStories(j);
				var logo = stories[stories.length-1];
				hideLogo(logo)
			}
		}
	});
	
	

	function openStory(parcel, story, j) {
		var title = story.subViews[1].subViews[1],
			image = story.subViews[0].subViews[1],
			body  = story.subViews[1].subViews[0];
			
		body.placeBefore(image);
		
		parcel.animate({
			properties: {
				y: 0
			},
			curve: "spring(250, 40, 200)"
		})

		story.animate({
			properties: {
				x: -20,
				y: 0
			},
			curve: "spring(250, 40, 200)"
		});
		
		title.animate({
			properties: {
				y: height - (title.height + cell*6)
			},
			curve: "spring(250, 40, 200)"
		});
		body.animate({
			properties: {
				y: body.y - cell*4.5
			},
			curve: "spring(250, 40, 200)"
		});

	}
	
	function hideLogo(logo) {
		logo.animate({
			properties: {
				y: -statusBarHeight*3.5,
			},
			curve: "spring(250, 40, 200)"
		})
	}
	
	function hideOtherStories(j) {
		for (k in stories) {
//	 		If not same index as current story
			if ((j != k) && (k < stories.length-1)) {
				stories[k].animate({
					properties: {
						x: 0,
						y: height*2
					},
					curve: "spring(250, 40, 200)"
				});
	
			}
		}
	}

}