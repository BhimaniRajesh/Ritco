/***********************************************************************
 * FILE: jquery.ptTimeSelect.js
 * 
 * 		jQuery plug in for displaying a popup that allows a user
 * 		to define a time and set that time back to a form's input
 * 		field.
 * 
 * 
 * AUTHOR:
 * 
 * 		*Paul T.*
 * 
 * 		- <http://www.purtuga.com>
 * 		- <http://pttimeselect.sourceforge.net>
 * 
 * 
 * DEPENDECIES:
 * 
 * 		-	jQuery.js
 * 			<http://docs.jquery.com/Downloading_jQuery>
 * 
 * 		- 	dimensions.js
 * 			<http://docs.jquery.com/Plugins>
 * 
 * 
 * LICENSE:
 * 
 * 		Copyright (c) 2007 Paul T. (purtuga.com)
 *		Dual licensed under the:
 *
 * 		-	MIT
 * 			<http://www.opensource.org/licenses/mit-license.php>
 * 
 * 		-	GPL
 * 			<http://www.opensource.org/licenses/gpl-license.php>
 * 
 * INSTALLATION:
 * 
 * 		This file <jquery.ptTimeSelect.js> is the only one required.
 * 		To install, simply copy it to the same directory as jquery.js
 * 		and include it in the html pages requiring it's functionality.
 * 
 * 
 * USAGE:
 * 
 * 		Usage of this plugin is via the <$(ele).ptTimeSelect()> method.
 * 		all others are internal to this plugin.
 * 
 * 		The default apperance can be controled by changing the value
 * 		in <jQuery.ptTimeSelect.html>
 * 
 * 
 * 
 * LAST UPDATED:
 * 
 * 		- $Date: 2007/05/16 20:50:57 $
 * 		- $Author: paulinho4u $
 * 		- $Revision: 1.1 $
 * 
 * 
 **********************************************************************/

/***********************************************************************
 * METHOD: jQuery.ptTimeSelectInit()
 * 		Internal method. Called when page is initalized to add the time
 * 		selection area to the DOM.
 * 
 * PARAMS:
 * 
 * 		none.
 * 
 * RETURNS:
 * 
 * 		nothing.
 * 
 * 
 */
jQuery.ptTimeSelectInit = function () {
	jQuery(document).ready(
		function () {
			//if the html is not yet created in the document, then do it now
			if (!jQuery('#ptTimeSelectCntr').length) {
				
				jQuery("body").append(
					  '<div id="ptTimeSelectCntr" style="display: none; border: 2px solid; z-index: 10; padding: 5px; left: 10px; top: 10px; position: absolute;">'
					+ '	<div id="ptTimeSelectCloseCntr1" style="text-align: right;font-weight: bold;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+'		<a href="javascript: void(0);" onclick="jQuery.ptTimeSelect.setTime();">[SET]</a>&nbsp;'
					+ '		<a href="javascript: void(0);" onclick="jQuery.ptTimeSelect.closeCntr();">[X]</a>'
					
					+ '	</div>'
					/* + '	<div id="ptTimeSelectSetButton" style="text-align: right; padding: 2px; font-size: smaller;font-weight: bold;">'
					+ '		<a href="javascript: void(0);" onclick="jQuery.ptTimeSelect.setTime();">[ SET ]</a>'
					+ '	</div>'*/
					+ '	<table id="ptTimeSelectTbl" width="3.0in" border="1"  cellpadding="2" cellspacing="0">'
					+ '		<tr align="center" valign="top">'
					+ '			<td colspan="7" align="center" style="font-weight: bolder;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+ '				<div id="ptTimeSelectUserTime" align="center" style="width: 100%;">'
					+ '		<span id="ptTimeSelectUserSelHr">1</span> : <span id="ptTimeSelectUserSelMin">00</span> <span id="ptTimeSelectUserSelAmPm">AM</span>'
					+ '		</div>'
					+ '			</td>'
					+ '		</tr>'
					+ '		<tr align="center" valign="top" style="font-weight: bolder;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+ '			<th id="ptTimeSelectHrLabel" colspan="4" style="">Hour</th>'
					+ '			<th id="ptTimeSelectMinLabel" colspan="3" style="">Minutes</th>'
					+ '		</tr>'
					+ '		<tr align="center" valign="top" style="font-weight: 500;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">1</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">5</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">9</a></td>'
					+ '			<td rowspan="2" align="center" valign="middle">'
					+ '				<a class="ptTimeSelectHr" href="javascript: void(0);">AM</a>'
					+ '			</td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">00</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">20</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">40</a></td>'
					+ '		</tr>'
					+ '		<tr align="center" valign="top" style="font-weight: 500;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">2</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">6</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">10</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">05</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">25</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">45</a></td>'
					+ '		</tr>'
					+ '		<tr align="center" valign="top" style="font-weight: 500;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">3</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">7</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">11</a></td>'
					+ '			<td rowspan="2" align="center" valign="middle">'
					+ '				<a class="ptTimeSelectHr" href="javascript: void(0);">PM</a>'
					+ '			</td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">10</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">30</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">50</a></td>'
					+ '		</tr>'
					+ '		<tr align="center" valign="top" style="font-weight: 500;FONT-SIZE: 11px;LINE-HEIGHT: 16px;FONT-FAMILY: verdana">'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">4</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">8</a></td>'
					+ '			<td><a class="ptTimeSelectHr" href="javascript: void(0);">12</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">15</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">35</a></td>'
					+ '			<td><a class="ptTimeSelectMin" href="javascript: void(0);">55</a></td>'
					+ '		</tr>'
					+ '	</table>'
				   
					
					+ '<!--[if lte IE 6.5]>'
					+ '	<iframe style="display:block; position:absolute;top: 0;left:0;z-index:-1;'
					+ '			filter:Alpha(Opacity=\'0\');width:3000px;height:3000px"></iframe>'
					+ '<![endif]-->'
					+ '</div>'
				);
				
				
				// Set the default width
				jQuery('#ptTimeSelectCntr').css({
						width: '100px',
						'border-color': '#FFFFFF'
				});
				
				// Add the events to the functions
				jQuery('.ptTimeSelectMin', jQuery('#ptTimeSelectCntr'))
					.bind("click", function(){
								jQuery.ptTimeSelect.setMin($(this).text());
	 				}).css({display: 'block'});
				
				jQuery('.ptTimeSelectHr', jQuery('#ptTimeSelectCntr'))
					.bind("click", function(){
						jQuery.ptTimeSelect.setHr( $(this).text() );
	 				}).css({display: 'block'});
				
				
				jQuery('#ptTimeSelectTbl', jQuery('#ptTimeSelectCntr')).css({
							'border': 			'1px solid #DDDBCB',
							'border-collapse':	'collapse'
						});
						
				jQuery('#ptTimeSelectTbl>td', jQuery('#ptTimeSelectCntr')).css({
							'border': '1px solid #DDDBCB'
						});
				
			}//end if
		}
	);
}(); /* jQuery.ptTimeSelectInit() */

/***********************************************************************
 * OBJECT: jQuery.ptTimeSelect
 * 		Object that will store the static functions of ptTimeSelect()
 */
jQuery.ptTimeSelect = {
	
	/***********************************************************************
	 * PROPERTY: jQuery.ptTimeSelect._counter
	 * 		Counter that insure that each element added to DOM has an
	 * 		unique id asociated with it.
	 * 
	 */
	_counter: 1,
	
	/**
	 * PROPERTY: jQuery.ptTimeSelect._eleOpt
	 * 		Object that maintains the options passed in for the element
	 * 		being built. Options are keept assicated with the unique id
	 * 		of the element created.
	 */
	_eleOpt: {},
	
	/***********************************************************************
	 * PROPERTY: jQuery.ptTimeSelect._curEle
	 * 		property that holds the current input element. It is set once
	 * 		the time selection popup is displayed to the user.
	 */
	_curEle:	"",
	
	/***********************************************************************
	 * PROPERTY: jQuery.ptTimeSelect.html
	 * 		Property holds the html options used in the generated code
	 * 		which is added to DOM.  Any of these values can be overriden
	 * 		by either defining them directly (ex.
	 * 		jQuery.ptTimeSelect.html.bgcolor: 'black';) or [PREFERABLY] via
	 * 		the <$(ele).ptTimeSelect()> method. The list of parameters that
	 * 		can be used to control the html are:
	 * 
	 * 		bgcolor				- The background color for the popup.
	 * 							  NOTE... This value will be ignored if a 
	 * 							  cntr_class is set.
	 * 		border_color		- The color to be associated with elements that
	 * 							  display a border
	 * 							  NOTE... This value will be ignored if a 
	 * 							  cntr_class is set.
	 * 		labels				- Object ({}) with the label definitions below.
	 * 		labels.x			- The value to be used inside of the popup close
	 * 							  link. This can also be an image (<img>). Default
	 * 							  is [Close]
	 * 		labels.popup_link	- The text to be used inside of the link
	 * 							  created next to the imput field. This can also be
	 * 							  an image (<img>). Default is [T]
	 * 		labels.set_time		- The text to be used inside of the link at the
	 * 							  bottom of the popup, that sets the time defined
	 * 							  back to the input field. This value can also be
	 * 							  an image. Default is SET
	 * 		cntr_width			- The width of the entire container that holds the
	 * 							  time definition element.
	 * 		cntr_class			- Class to be associated with the entire container
	 * 							  of the popup area. This is a <div> element that
	 * 							  contains a table and the set button. See the 
	 * 
	 * 
	 * 
	 * 
	 */
	html:	{
		bgcolor:		'#FFFFFF',
		border_color:	'#8BA0E5',
		labels: {
				x:			'[Close]',
				popup_link:	'[T]',
				set_time:	'[Set]'
		},
		'cntr_width':	'130px',
		'cntr_class':	''
	},
	
	/***********************************************************************
	 * FUNCTION: jQuery.ptTimeSelect.getLabel()
	 * 		Returns a label requested by caller.
	 *
	 * PARAMS:
	 *
	 * 		lbl	-	[string] Required. Label token
	 * 		uId	-	[string] Optional. Unique id of current
	 * 				timeDate instance.
	 *
	 * RETURNS:
	 *
	 * 		- [string] Label requested.
	 *
	 */
	getLabel: function (lbl, uId) {
		if (!lbl) {return;};
		var self = jQuery.ptTimeSelect;
		if (	self._eleOpt[uId]
			&&	self._eleOpt[uId].labels
			&&	self._eleOpt[uId].labels[lbl]
		) {
			return self._eleOpt[uId].labels[lbl];
		} else {
			return self.html.labels[lbl];
		};
	},/* end jQuery.ptTimeSelect.getLabel */
	
	/***********************************************************************
	 * METHOD: jQuery.ptTimeSelect.getOpt()
	 * 		Retrieves and returns options set by the user or the defaults
	 * 
	 * PARAMS:
	 * 
	 * 		oName	-	Options name.
	 * 		uId		-	Unique id of the element being processed.		
	 * 
	 * RETURN:
	 * 
	 * 		none
	 * 
	 */
	getOpt: function (oName, uId) {
			if (!oName) {return;};
			if (	uId
				&&	this._eleOpt[uId]
				&&	this._eleOpt[uId][oName]
			) {
				return this._eleOpt[uId][oName];
			} else {
				return this.html[oName];
			};
	}, /* END openCntr() function */
	
	/***********************************************************************
	 * METHOD: jQuery.ptTimeSelect.setHr(h)
	 * 		Sets the hour selected by the user on the popup.
	 * 
	 * 
	 * PARAMS:
	 * 
	 * 		h -	[int] interger indicating the hour. This value is the same
	 * 			as the text value displayed on the popup under the hour.
	 * 			This value can also be the words AM or PM.
	 * 
	 * 
	 * RETURN:
	 * 
	 * 		none
	 */
	setHr:	function(h) {
			if (	h.toLowerCase() == "am"
				||	h.toLowerCase() == "pm"
			) {
				jQuery('#ptTimeSelectUserSelAmPm').empty().append(h);
			} else {
				jQuery('#ptTimeSelectUserSelHr').empty().append(h);
			}
	},/* END setHr() function */
	
	/***********************************************************************
	 * METHOD: jQuery.ptTimeSelect.setMin(m)
	 * 		Sets the minutes selected by the user on the popup.
	 * 
	 * 
	 * PARAMS:
	 * 
	 * 		m -	[int] interger indicating the minutes. This value is the same
	 * 			as the text value displayed on the popup under the minutes.
	 * 
	 * 
	 * RETURN:
	 * 
	 * 		none
	 */
	setMin:	function(m) {
				jQuery('#ptTimeSelectUserSelMin').empty().append(m);
		
	},/* END setMin() function */
	
	/***********************************************************************
	 * METHOD: jQuery.ptTimeSelect.setTime()
	 * 		Takes the time defined by the user and sets it to the input
	 * 		element that the popup is currently opened for (as stored in
	 * 		jQuery.ptTimeSelect._curEle)
	 * 
	 * 
	 * PARAMS:
	 * 
	 * 		none.
	 * 
	 * 
	 * RETURN:
	 * 
	 * 		none
	 */
	setTime:	function() {
				var tSel = jQuery('#ptTimeSelectUserSelHr').text()
							+ ":"
							+ jQuery('#ptTimeSelectUserSelMin').text()
							+ " "
							+ jQuery('#ptTimeSelectUserSelAmPm').text()
				jQuery(this._curEle).val(tSel);
				this.closeCntr();
				
			},/* END setTime() function */
	
	/***********************************************************************
	 * METHOD: jQuery.ptTimeSelect.openCntr()
	 * 		Displays the time definition area on the page, right below
	 * 		the input field.  Also sets the custom colors/css on the
	 * 		displayed area to what ever the input element options were
	 * 		set with.
	 * 
	 * PARAMS:
	 * 
	 * 		uId	-	STRING. Id of the element for whom the area will
	 * 				be displayed. This ID was created when the 
	 * 				ptTimeSelect() method was called.
	 * 
	 * RETURN:
	 * 
	 * 		nothing.
	 * 
	 */
	openCntr:	function (uId) {
				uId = uId;
				uId2= '#' + uId;
				var cntr = jQuery('#ptTimeSelectCntr').hide(0);
				var offset	= jQuery(uId2).offset();
				offset.top	+= jQuery(uId2).height();
				
				//if IE, then offset some... bad ie (as usual)  :(
				if (jQuery.browser.msie) {
					offset.top	-= 10;
					offset.left	-= 10;
				}
				
				// Insure pixels are used
				offset.top	+= "px"
				offset.left	+= "px"
				
				// set the default time.
				jQuery.ptTimeSelect.setHr('12');
				jQuery.ptTimeSelect.setMin('00');
				jQuery.ptTimeSelect.setHr('PM');
				
				// Set the labels
				jQuery('#ptTimeSelectCloseCntr>a', cntr).empty()
						.append(this.getLabel('x', uId));
				
				jQuery('#ptTimeSelectSetButton>a').empty()
						.append(this.getLabel('set_time' , uId));
				
				// if the options to this input field has a 
				// cntr_class defined, then associate it to this
				// menu container.
				if (this.getOpt('cntr_class', uId)) {
					
					// Remove any background and class currently set on the
					// overall container
					cntr.css({
							'width': '',
							'background-color': ''
					});
					
					jQuery('#ptTimeSelectSetButton>a', cntr).css(
							'border-color', this.getOpt('border_color', uId) );
					
					jQuery('#ptTimeSelectTbl', cntr).css({
							'border-color': '',
							'width': '' });
							
					jQuery('#ptTimeSelectTbl>td', cntr).css({
								'border': ''
							});
					
					//Remove any class currently on it, and add the correct one
					cntr.removeClass().addClass(this.getOpt('cntr_class', uId));
					
				// else, no class for this input field. Set colors
				// using the ones defined for it.
				} else {
					
					// Set the colors
					cntr.removeClass().css({
							'background-color':	this.getOpt('bgcolor', uId),
							'border-color':		this.getOpt('border_color', uId),
							'width':			this.getOpt('cntr_width', uId)
					});
					
					jQuery('#ptTimeSelectSetButton>a', cntr).css(
						'border-color', this.getOpt('border_color', uId) );
					
					jQuery('#ptTimeSelectTbl', cntr).css({
						'border': 			'1px solid ' + this.getOpt('border_color', uId),
						'border-collapse':	'collapse'
					});
							
					jQuery('#ptTimeSelectTbl>td', cntr).css(
							'border', '1px solid ' + this.getOpt('border_color', uId)
					);
					
				}//end if
				
				// display the popup and store the current element
				cntr.css(offset).slideDown("midium");
				jQuery.ptTimeSelect._curEle = jQuery(uId2 + '>input');
				
	},/* END openCntr() function */
	
	/***********************************************************************
	 * METHOD: jQuery.ptTimeSelect.closeCntr()
	 * 		Closes (hides it) the popup container.
	 * 
	 * PARAMS:
	 * 
	 * 		none.
	 * 
	 * RETURN:
	 * 
	 * 		none 
	 * 
	 */
	closeCntr:	function() {
				jQuery('#ptTimeSelectCntr').slideUp("fast");
				this._curEle = "";
				return;
				
	} /* END setTime() function */
			
}/* END jQuery.ptTimeSelect object */


/***********************************************************************
 * METHOD: $(ele).ptTimeSelect()
 * 		PUBLIC METHOD. Displays an html popup that allows the user to
 * 		define a time, which will then be written to the form element.
 * 		Each element matched will be wrapped with html code that will
 * 		display a link next to the field that allows the user to view
 * 		the popup area for defining the time.
 * 		This is the only method that is expected to be used externally
 * 		for implementation into a web page.
 * 
 * 
 * PARAMS:
 * 
 * 		{OBJECT}	-	(Optional) An object in the same structure as
 * 						the <jQuery.ptTimeSelect.html> global element.
 * 						Example:
 * 
 * |		{	bgcolor: '#fff',
 * |			labels: {
 * |				x: '[Close Window]',
 * |				popup_link: '[Define Time]',
 * |				setTime: 'Save Time'
 * |			}
 * |		}
 * 
 * 
 * RETURNS:
 * 
 * 		- {object} jQuery
 * 
 * 
 * EXAMPLE:
 * 
 * 		-	Example below will wrap an input box with id of 'fooTime' with
 * 			a link that when click, will allow the user to define a time.
 * 
 * 	|		$('#fooTime').ptTimeSelect();
 * 
 * 
 * 
 */
jQuery.fn.ptTimeSelect = function(opt) {
	this.each(function(){
		if(this.nodeName.toLowerCase() != 'input') return;
		
		//Define a unique id and increment global counter var
		var uId = 'ptTimeSelect_'  + jQuery.ptTimeSelect._counter;
		jQuery.ptTimeSelect._counter += 1;
		
		// if the options are true, then set it in the global var
		if (opt) {
			jQuery.ptTimeSelect._eleOpt[uId] = opt; }
	
		//Wrap the input field in a <div> element with
		// a unique id for later referencing.
		jQuery(this).wrap('<div style="display: inline;" id="' + uId + '"></div>' );
	
		//insert the link to popup the calendar
		jQuery(
				'<a href="javascript:void(0);" onclick="jQuery.ptTimeSelect.openCntr(\''
			+	uId
			+	'\');">'
			+	jQuery.ptTimeSelect.getLabel('popup_link',uId)
			+	'</a>').appendTo(jQuery('div#' + uId));
			
		return this;
	});
};/* End of jQuery.fn.timeSelect */


/***********************************************************************
 * SECTION: HTML INSETED INTO DOM
 * 		Below is the html added to DOM for the time definition element. Use
 * 		this when attempting to build CSS rules for controlling the appearance
 * 		of the popup.
 * 
 * 
 * TOPIC: Time Definition Popup
 * 
 * 	|	  <div style="border: 2px solid rgb(221, 219, 203); 
 * 	|	  				padding: 5px; 
 * 	|	  				overflow: visible;
 * 	|	  				display: block;
 * 	|	  				z-index: 10;
 * 	|	  				left: 529px;
 * 	|	  				top: 394px;
 * 	|	  				position: absolute;
 * 	|	  				width: 200px;
 * 	|	  				background-color: rgb(235, 234, 227);
 * 	|	  				height: 215px;"
 * 	|	  		id="ptTimeSelectCntr" class="">
 * 	|	    <div style="padding: 2px; 
 * 	|	    			text-align: right;
 * 	|	    			font-size: smaller;
 * 	|	    			font-weight: bold;"
 * 	|	    	id="ptTimeSelectCloseCntr">
 * 	|	      <a onclick="jQuery.ptTimeSelect.closeCntr();" href="javascript:%20void(0);">[Close]</a>
 * 	|	    </div>
 * 	|	    <table width="100%" cellspacing="0" cellpadding="2" border="1" id="ptTimeSelectTbl" 
 * 	|	    		style="border: 1px solid rgb(221, 219, 203); border-collapse: collapse;">
 * 	|	      <tbody>
 * 	|	        <tr valign="top" align="center">
 * 	|	          <td align="center" style="font-weight: bold; font-size: larger;" colspan="7">
 * 	|	            <div align="center" style="width: 100%;" id="ptTimeSelectUserTime">
 * 	|	              <span id="ptTimeSelectUserSelHr">12</span> : 
 *	|                 <span id="ptTimeSelectUserSelMin">00</span> 
 * 	|	              <span id="ptTimeSelectUserSelAmPm">PM</span>
 * 	|	            </div>
 * 	|	          </td>
 * 	|	        </tr>
 * 	|	        <tr valign="top" align="center" style="font-weight: bold;">
 * 	|	          <th style="" colspan="4" id="ptTimeSelectHrLabel">Hour</th>
 * 	|	          <th style="" colspan="3" id="ptTimeSelectMinLabel">Minutes</th>
 * 	|	        </tr>
 * 	|	        <tr valign="top" align="center">
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">1</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">5</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">9</a></td>
 * 	|	          <td valign="middle" align="center" rowspan="2">
 * 	|	          	<a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">AM</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">00</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">20</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">40</a></td>
 * 	|	        </tr>
 * 	|	        <tr valign="top" align="center">
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">2</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">6</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">10</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">05</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">25</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">45</a></td>
 * 	|	        </tr>
 * 	|	        <tr valign="top" align="center">
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">3</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">7</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">11</a></td>
 * 	|	          <td valign="middle" align="center" rowspan="2">
 * 	|	          	<a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">PM</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">10</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">30</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">50</a></td>
 * 	|	        </tr>
 * 	|	        <tr valign="top" align="center">
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">4</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">8</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectHr" style="display: block;">12</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">15</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">35</a></td>
 * 	|	          <td><a href="javascript:%20void(0);" class="ptTimeSelectMin" style="display: block;">55</a></td>
 * 	|	        </tr>
 * 	|	      </tbody>
 * 	|	    </table><br>
 * 	|	    <div align="right" style="margin: 5px; text-align: right; font-weight: bold;" id="ptTimeSelectSetButton">
 * 	|	      <a onclick="jQuery.ptTimeSelect.setTime()" style="border: 1px solid rgb(221, 219, 203); padding: 5px;" href="javascript:%20void(0);">SET</a>
 * 	|	    </div><!--[if lte IE 6.5]>
 * 	|	    	<iframe style="display:block; position:absolute;top: 0;left:0;z-index:-1;
 * 	|					filter:Alpha(Opacity='0');width:3000px;height:3000px"></iframe><![endif]-->
 * 	|	  </div>
 * 
 * 
 * TOPIC: Matched Input Fields
 * 
 * 	|	<div id="ptTimeSelect_1" style="display: inline;">
 * 	|		<input name="s1Time2"/><a onclick="jQuery.ptTimeSelect.openCntr('ptTimeSelect_1');" href="javascript:void(0);">[T]</a>
 * 	|	</div>
 * 
 * 
 * 
 * 
 */


