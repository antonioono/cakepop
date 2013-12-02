/// GLOBALS ///

var p               = PSD,
    container       = p["Container-scroll"],
    statusBar       = p["Status bar"],
    curve			= "spring(250, 40, 500)",
    fastCurve       = "spring(200,30,700)",
    smoothCurve     = "spring(250, 40, 200)",
    cell			= 24,
	statusBarHeight = 36,
	height 			= 1136,
	width			= 640,
	threshhold		= 50,
	scrollOffset    = 1280,
	backParcelCount,
	storyOpen		= false,
	parcelOpen		= false;


/// RENDER ///

container.opacity = 0;
setTimeout(function() {
	render();
}, 500)

function render() {
	for (var i in container.subViews) { // Loop through bundles
		var parcel			= container.subViews[i],
			stories	        = parcel.subViews,
			coverStory 		= stories[stories.length-2].subViews[0],
			storyX;	
			
        backParcelCount = stories.length-3;
        console.log(backParcelCount)
		setupParcel				(parcel, stories, coverStory, i);
		bindParcelEvents		(parcel, stories, coverStory, i);
		
		for (var j in stories) {
			var story = stories[j];
			setupStory		(stories, story, j)
			bindStoryEvents	(parcel, stories, coverStory, i, story, j);			
		}
		
	}
}

function setupContainer() {
    container.opacity = 1;
    // Set container scroll position
    container._element.scrollLeft = scrollOffset;
    container.on("scroll", function(){
        // console.log(container._element.scrollLeft)
        if (container._element.scrollLeft > scrollOffset + 200) {
            container._element.scrollLeft = scrollOffset + 200
        }
        
        if (parcelOpen) {
            container._element.scrollLeft = scrollOffset;
        }
    });
}

function setupParcel(parcel, stories, coverStory, i) {
	var multiple	= i+1,
		parcelX,
		title		= coverStory.subViews[1].subViews[1];
	
	// Even divides space between parcels until they become too narrow (at 4 parcels)
	if (stories.length > 3) {
    	parcelX = (width / 3.25) * i;
	} else {
        parcelX = (width / stories.length) * i;
	}
	
	setupContainer();
		
	parcelX += scrollOffset;
	parcelX -=  (width / 3.25)*(backParcelCount+1);
	
	// Vary height
	// parcel.y = (cell * 4) + (cell * Math.round(Math.random() * 5));
	
    // Make first couple parcels old issues
    if ((i <= backParcelCount) && (stories.length > 4)) {
        parcelX -=  (width / 3.25)*(backParcelCount-2);
	    parcel.x = parcelX+20
        setupBackParcel(parcel, stories, i);		    
	} else {
        // Set initial parcel position
    	parcel.x = width + scrollOffset;

        // Animate in parcels
        setTimeout(function() {
            parcel.animate({
                properties: {
                    x:  parcelX+(cell*2)
                },
                curve: fastCurve
            });
        }, 250 * (stories.length-i));
        
	}
}

function setupBackParcel(parcel, stories, i) {
//  Dim image
    stories[stories.length-2].subViews[0].subViews[1].opacity = .333;
//  Dim logo
    stories[stories.length-1].opacity = .5;
    parcel.opacity = 0;
//  Delay appearance of back issues so they don't show before new issues animate in
    setTimeout(function(){
        parcel.animate({
            properties: {
                opacity: 1
            },
            time: 1500,
            curve: "ease-out"
        });
    }, 1000);
}

function bindParcelEvents(parcel, stories, coverStory, i) {
	parcel.on("click", function(){
		
		if (!parcelOpen) {
			openParcel();
			hideOtherParcels(parcel);
			parcelOpen = true;
		}
		
// 		Slide parcel to left
		function openParcel() {
    		container._element.scrollLeft = scrollOffset;
			parcel.animate({
				properties: {
					x: 20 + scrollOffset
				},
				curve: smoothCurve
			});
			setTimeout(function() {
//              Return parcel to top because of variable height
    			parcel.animate({
    			    properties: {
    			         y: statusBarHeight
    			    },
    			    curve: "spring(400, 40, 20)"
    			});
			}, 1000);
			for (var k in stories) {
				layoutStories(k);
			}
		}
		
		function hideOtherParcels(currentParcel) {
// 		    Hide other parcels
			for (var j in container.subViews) {
//  			If not the current parcel
				if (j != parseInt(i)) {
					var otherParcel = container.subViews[j],
                        otherParcelX;
                    if (otherParcel.x < currentParcel.x) {
//   					If to left of current parcel, x is offscreen to left
                        otherParcelX = scrollOffset - width
                    } else {
//   					If to right of current parcel, x is offscreen to right
                        otherParcelX = width+cell + scrollOffset                        
                    }
					otherParcel.animate({
						properties: {
						 	x: otherParcelX,
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
				 		y: (statusBarHeight*3) + (cell * (k * 16))
				 	},
					curve: fastCurve
				});
				 
//	   			Display titles; move to top
				animateInTitles(story, k);
//				Move logo to top
				moveLogo(k)
			}, 1000)
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
		 
		 function moveLogo(k) {
// 		    Move logo
            var logo = stories[stories.length-1];
		  	logo.animate({
		  		properties: {
		  			// opacity: 0
		  			scale: .333,
		  			y: 0,
		  			x: (width/2) - (logo.width/1.8125)
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
				hideLogo(logo);
				hideStatusBar();
				
				storyOpen = true;
			}
		}
		
// 		Prevent text from scrolling unless parcel is open
		var text = story.subViews[1];
		text.on("scroll", function() {
		    if (!storyOpen) {
		        text._element.scrollTop = 0;
		    }
		});
	});
	
	

	function openStory(parcel, story, j) {
		var text  = story.subViews[1],
            title = text.subViews[1],
            body  = text.subViews[0],
			image = story.subViews[0].subViews[1];
			
		body.placeBefore(image);
		
		parcel.animate({
			properties: {
				y: 0
			},
			curve: smoothCurve
		})

		story.animate({
			properties: {
				x: -20,
				y: 0
			},
			curve: smoothCurve
		});
		
		title.animate({
			properties: {
				y: height - (title.height + cell*6)
			},
			curve: smoothCurve
		});
		
		body.animate({
			properties: {
				y: body.y - cell*4.5
			},
			curve: smoothCurve
		});

	}
	
	function hideLogo(logo) {
		logo.animate({
			properties: {
				y: -statusBarHeight*3.5,
			},
			curve: smoothCurve
		})
	}
	
	function hideStatusBar() {
    	statusBar.animate({
            properties: {
                opacity: 0
            },
            curve: smoothCurve
        })
	}
	
	function hideOtherStories(j) {
		for (k in stories) {
//	 		If not same index as current story
			if ((j != k) && (k < stories.length-1)) {
    			var otherStoryY;
//     			If above current story
                if (stories[k].y < stories[j].y) {
                    otherStoryY = -height
                } else {
                    otherStoryY = height
                }
				stories[k].animate({
					properties: {
						x: -21,
						y: otherStoryY
					},
					curve: smoothCurve
				});
	
			}
		}
	}

}