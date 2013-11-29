document.ontouchstart = function(e){ 
	e.preventDefault(); 
}

var p = PSD;

/// GLOBALS ///

var statusBarHeight = 36,
	height 			= 1136,
	cardWidth		= 640,
	curve			= "spring(300,40, 200)",
	threshhold		= 50;

/// RENDER ///

render();

function render() {
	for (var i in p.Content.subViews) { // Loop through bundles
		var bundle			= p["Bundle"+i],
			cover 			= p["Cover"+i+"-draggable"],
			stories 		= p["Stories"+i],
			storiesLength	= stories.subViews.length,
			storyIsOpen		= false,
			storyX;	

	/// COVER ///
		setupBundle(bundle);
		bindCoverEvents(cover);
	
	/// STORIES /// 
		setupStories(stories);
		bindStoryEvents(stories);
	}
}

function setupBundle(bundle) {
	for (var j in p.Content.subViews) {
		var bundleCover = p.Content.subViews[0],
			l    		= p.Content.subViews.length;
			
		// stackCards(bundleCover, bundle, false, j, l);
	}
}

function bindCoverEvents(cover) {
	var noDrag;
	cover.x = 0;
	
	cover.on(Events.DragMove, function(){
		cover.y			= 0;
		console.log('drag')
		// cover.opacity	= 1-(Math.abs(cover.x)/(cardWidth));
		// cover.blur	= Math.abs(cover.x/2);
	});
	
	cover.draggable.on(Events.DragEnd, function(){	
		if (cover.x < -100) {		// LEFT
			cover.animate({
				properties: {
					x: -cardWidth,
					// opacity: .5
				},
				time: 250,
				curve: curve
			});
		} else if (cover.x > 100) {	// RIGHT
			cover.animate({
				properties: {
					x: cardWidth,
					// opacity: .5
				},
				time: 250,
				curve: curve
			});
		} else if (cover.x === 0) {
			var coverBounce = cover.animate({
					properties: {
						x: -48
					},
					time: 100,
					curve: "ease-out"
				});
			coverBounce.on("end", function(){
				cover.animate({
					properties: {
						x: 0,
						opacity: 1
					},
					time: 250,
					curve: "spring(500, 20, 100)"
				});
			});
		} else {
			cover.animate({
				properties: {
					x: 0,
					opacity: 1
				},
				time: 250,
				curve: "spring(500, 20, 100)"
			});
		}
	});
}

function setupStories(stories) {
	for (var j in stories.subViews) {
		var story 		= stories.subViews[j],
			storyCover 	= story.subViews[1],
			storyText   = story.subViews[0],
			l    	= stories.subViews.length;
			
		stackCards(story, storyCover, storyText, j, l);
	}
}

function stackCards(card, cover, text, j, l) {
	card.opacity = 1;
	console.log(l)

	card.animate({
		properties: {
			y: statusBarHeight + (height/l)*j,
			x: 0,
			scale: 1,
			opacity: 1
		},
		curve: curve
	}).on("end", function(){
		storyIsOpen = false;
	});

	cover.animate({
		properties: {
			scale: .875,
		},
		curve: curve
	});
	
	if (text) {
		// console.log(card)
		text.animate({
			properties: {
				scale: .875,
				opacity: 0
			},
			curve: curve
		});
	}

	// storyCover.style.webkitTransform = "scale(.875)"
	// storyCover.style.webkitTransform = "rotate3d(20deg, 20deg, 90deg)"
	// storyCover.style.webkitTransformOrigin = "bottom left"
}

function bindStoryEvents(stories) {
	currentPage = 0;
	for (var j in stories.subViews) {
		var story 		= stories.subViews[j],
			storyCover 	= story.subViews[1],
			storyText   = story.subViews[0];
			
		/// POSITIONING, ETC. ///
		
		/// DRAGGING ///
		
		var storyXStart, storyXEnd,
			storyYStart, storyYEnd;
	
		story.draggable.on(Events.DragStart, function(){
			storyXStart	= story.x;
			storyYStart	= story.y;
			storyWidth	= story.width - cardWidth;
			if (storyIsOpen) {
				storyText.opacity = 1;
				storyText.scale   = 1;
			}
		});
		
		story.on(Events.DragMove, function(){
			if (story.y < 0) story.y = 0; // prevent from leaving top
			console.log(storyIsOpen);
		});
		
		story.draggable.on(Events.DragEnd, function(){
			storyXEnd = story.x;
			storyYEnd = story.y;
	
			/// PULL DOWN TO GO BACK ///
			if (storyIsOpen) {
				if (story.y > storyYStart) {
					console.log("Close article")
					setupStories(stories);
				}/// PAGINATION ///
				else if (story.x > 0) {
					animateX(story, 0);
				} else if (-story.x > storyWidth) {
					animateX(story, -storyWidth);
				} else if (storyXStart > storyXEnd) { // Next
					currentPage += 1;
					animateX(story, -currentPage*cardWidth);
				} else if (storyXStart < storyXEnd) { // Previous
					currentPage -= 1;
					animateX(story, -currentPage*cardWidth);
				}
			} else {
				openStory(stories, j, story)
			}
		});
	}
	
	function openStory(stories, j, story) {
		var storyOldX = 0;
		console.log("openArticle", storyIsOpen)
		if (!(storyIsOpen)) {
			for (var k in stories.subViews) {
				var storyOldX = 0;
				
			/// STORIES NOT CLICKED
				if (k!=j) {
					stories.subViews[k].animate({
						properties: {
							// y: stories.subViews[k].y+(height/2),
							// y: (height/(stories.subViews.length/2))*k
							y: height,
							// opacity: .,
						},
					}),
					stories.subViews[k].subViews[1].animate({
						properties: {
							scale: 1-((stories.subViews.length-k)*.1)
						},
						curve: "spring(300,"+(40+k*3)+", 50)"
					});
				}
			}
	
			/// OPEN CLICKED STORY ///
			story.animate({
				properties: {
					y: 0,
					x: 0
				},
				curve: "spring(250,40, 100)"
			});
	
			storyCover.animate({
				properties: {
					scale: 1
				},
				curve: curve
			});
		}
		storyIsOpen = true;
	}
}

function animateX(view, x) {
	console.log("AnimateX");
	// view.x = x;
	view.animate({
		properties: {
			x: x
		},
		time: 250,
		curve: curve
	});
}


