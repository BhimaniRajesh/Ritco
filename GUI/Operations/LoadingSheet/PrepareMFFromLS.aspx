<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PrepareMFFromLS.aspx.cs" Inherits="GUI_Operations_LoadingSheet_PrepareMFFromLS" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">
        
        function ManageAllDockets(objCheckAll)
        {
            var strMode = "1";
            var mTotalRecords = 0;
            var mDerivedControl = "";
            
            if(strMode == "1")
            {
                if(document.getElementById("ctl00_MyCPH1_HidTotalRecords") && document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos") && document.getElementById("ctl00_MyCPH1_HidSelectedDocketIDs"))
                {
                    mTotalRecords = document.getElementById("ctl00_MyCPH1_HidTotalRecords").value;
                    
                    for(var mLoopCounter = 0; mLoopCounter < mTotalRecords; mLoopCounter++)
                    {
                        mDerivedControlName = "ctl00_MyCPH1_rptDocketListForMF_ctl" + (mLoopCounter > 9 ? "" : "0") + mLoopCounter + "_chkSelDocket";
                        
                        if(document.getElementById(mDerivedControlName))
                        {
                            document.getElementById(mDerivedControlName).checked = objCheckAll.checked;
                        }
                    }
                    
                    if(objCheckAll.checked == true)
                    {
                        document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value = document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos").value;
                        document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value = document.getElementById("ctl00_MyCPH1_HidSelectedToHubNos").value;
                        document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value = document.getElementById("ctl00_MyCPH1_HidSelectedPackageNos").value;
                        document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value = document.getElementById("ctl00_MyCPH1_HidSelectedWeightNos").value;
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value = "";
                        document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value = "";
                        document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value = "";
                        document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value = "";
                    }
                }
                else
                {
                    alert("Hidden control not found for either Total No. of Records or Total No. of " + document.getElementById("ctl00_MyCPH1_HidDocket").value + "s!");
                    return false;
                }
            }
        }
        
        function disableenter()
        {
        
        }
        
        function trimAll(strValue) 
        {
            //Trimming left most white space characters
            while (strValue.substring(0,1) == ' ')
            {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length-1, strValue.length) == ' ')
            {
                strValue = strValue.substring(0, strValue.length-1);
            }
            
            return strValue;
        }        
        
        function SelectDocket(objDocket)
        {
            var strDocketMode = objDocket.DocketMode;
            var strDocketNo = objDocket.value;
            var strGiveAlert = objDocket.GiveAlert;
            var strToHub = objDocket.DelyLoc;
            
            var mArrSelectedDockets;
            var mSelectedDockets = "";
            var mArrSelectedToHubs;
            var mSelectedToHubs = "";
            var mArrSelectedPackages;
            var mSelectedPackages = "";
            var mArrSelectedWeights;
            var mSelectedWeights = "";
            /*var mArrSelectedDocketIDs;
            var mSelectedDocketIDs = "";*/
            
            if(objDocket.checked == true)
            {
                if (strDocketMode == "Q" && strGiveAlert == "Y")
                {
                    alert(document.getElementById("ctl00_MyCPH1_HidDocket").value + " Operationaly Incomplete!");
                    objDocket.checked = false;
                    return false;
                }
            }
            
            if(objDocket.checked == false)
            {
                if(document.getElementById("ctl00_MyCPH1_chkAll"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkAll").checked == true)
                    {
                        document.getElementById("ctl00_MyCPH1_chkAll").checked = false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_HidSelectedDockets") && document.getElementById("ctl00_MyCPH1_HidSelectedToHub") && document.getElementById("ctl00_MyCPH1_HidSelectedToHub"))
                {
                    //mArrSelectedDocketIDs = document.getElementById("ctl00_MyCPH1_HidSelectedDocketIDs").value.split(",");
                    mArrSelectedDockets = document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value.split(",");
                    mArrSelectedToHubs = document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value.split(",");
                    mArrSelectedPackages = document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value.split(",");
                    mArrSelectedWeights = document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value.split(",");
                    
                    for(var mLoopCounter = 0; mLoopCounter < mArrSelectedDockets.length; mLoopCounter++)
                    {
                        if(mArrSelectedDockets[mLoopCounter] != strDocketNo)
                        {
                            //mSelectedDocketIDs = (mSelectedDocketIDs == "" ? mArrSelectedDocketIDs[mLoopCounter] : mSelectedDocketIDs + "," + mArrSelectedDocketIDs[mLoopCounter]);
                            mSelectedDockets = (mSelectedDockets == "" ? mArrSelectedDockets[mLoopCounter] : mSelectedDockets + "," + mArrSelectedDockets[mLoopCounter]);
                            mSelectedToHubs = (mSelectedToHubs == "" ? mArrSelectedToHubs[mLoopCounter] : mSelectedToHubs + "," + mArrSelectedToHubs[mLoopCounter]);
                            mSelectedPackages = (mSelectedPackages == "" ? mArrSelectedPackages[mLoopCounter] : mSelectedPackages + "," + mArrSelectedPackages[mLoopCounter]);
                            mSelectedWeights = (mSelectedWeights == "" ? mArrSelectedWeights[mLoopCounter] : mSelectedWeights + "," + mArrSelectedWeights[mLoopCounter]);
                        }
                    }
                    
                    //document.getElementById("ctl00_MyCPH1_HidSelectedDocketIDs").value = mSelectedDocketIDs;
                    document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value = mSelectedDockets;
                    document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value = mSelectedToHubs;
                    document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value = mSelectedPackages;
                    document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value = mSelectedWeights;
                }
            }
            else
            {
                document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value = (document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value == "" ? strDocketNo : document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value + "," + strDocketNo);
                //document.getElementById("ctl00_MyCPH1_HidSelectedDocketIDs").value = (document.getElementById("ctl00_MyCPH1_HidSelectedDocketIDs").value == "" ? strDocketID : document.getElementById("ctl00_MyCPH1_HidSelectedDocketIDs").value + "," + strDocketID);
                document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value = (document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value == "" ? strToHub : document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value + "," + strToHub);
                
                var mTotalRecords;
                
                if(document.getElementById("ctl00_MyCPH1_HidTotalRecords"))
                {
                    mTotalRecords =  document.getElementById("ctl00_MyCPH1_HidTotalRecords").value
                }
                
                var mDerivedControlNameForPackages;
                var mDerivedControlNameForWeights;
                
                for(var mLoopCounter = 0; mLoopCounter < mTotalRecords; mLoopCounter++)
                {
                    if(mLoopCounter < 10)
                    {
                        mDerivedControlNameForPackages = "ctl00_MyCPH1_rptDocketListForMF_ctl" + "0" + mLoopCounter + "_txtPackagesLB"
                        mDerivedControlNameForWeights = "ctl00_MyCPH1_rptDocketListForMF_ctl" + "0" + mLoopCounter + "_txtWeightLB"
                    }
                    else
                    {
                        mDerivedControlNameForPackages = "ctl00_MyCPH1_rptDocketListForMF_ctl" + mLoopCounter + "_txtPackagesLB"
                        mDerivedControlNameForWeights = "ctl00_MyCPH1_rptDocketListForMF_ctl" + mLoopCounter + "_txtWeightLB"
                    }
                    
                    if(document.getElementById(mDerivedControlNameForPackages))
                    {
                        if(document.getElementById(mDerivedControlNameForPackages).DocketNo == strDocketNo)
                        {
                            document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value = (document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value == "" ? document.getElementById(mDerivedControlNameForPackages).value : document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value + "," + document.getElementById(mDerivedControlNameForPackages).value);
                        }
                    }
                    if(document.getElementById(mDerivedControlNameForWeights))
                    {
                        if(document.getElementById(mDerivedControlNameForWeights).DocketNo == strDocketNo)
                        {
                            document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value = (document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value == "" ? document.getElementById(mDerivedControlNameForWeights).value : document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value + "," + document.getElementById(mDerivedControlNameForWeights).value);
                        }
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_HidSelectedDockets") && document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos"))
                {
                    if(document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value == document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos").value)
                    {
                        if(document.getElementById("ctl00_MyCPH1_chkAll"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_chkAll").style.display == "")
                            {
                                if(document.getElementById("ctl00_MyCPH1_chkAll").checked == false)
                                {
                                    document.getElementById("ctl00_MyCPH1_chkAll").checked = true;
                                }
                            }
                        }
                    }
                }
            }            
        }
        
        function CheckDocketSelection()
        {
            //Check for Docket
            if(document.getElementById("ctl00_MyCPH1_HidSelectedDockets"))
            {
                if(document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value == "")
                {
                    alert("Select atleast one " + document.getElementById("ctl00_MyCPH1_HidDocket").value + " to prepare " + document.getElementById("ctl00_MyCPH1_HidMF").value + "!");
                    return false;
                }
            }
            else
            {
                alert("Hidden element for " + document.getElementById("ctl00_MyCPH1_HidDocket").value + " list is not available!");
                return false;
            }
            
            //Check for To Hub
            if(document.getElementById("ctl00_MyCPH1_HidSelectedToHub"))
            {
                if(document.getElementById("ctl00_MyCPH1_HidSelectedToHub").value == "")
                {
                    alert("Select atleast one " + document.getElementById("ctl00_MyCPH1_HidDocket").value + " to prepare " + document.getElementById("ctl00_MyCPH1_HidMF").value + "!");
                    return false;
                }
            }
            else
            {
                alert("Hidden element for to hub list is not available!");
                return false;
            }
            
            if(checkPackagesWeightChanges() == false)
            {
                return false;
            }
            
            return true;
        }
        
        function checkPackagesWeightChanges()
        {
            //Check for changes in packages and weight for respective change
            var mArrWeights = document.getElementById("ctl00_MyCPH1_HidSelectedWeightNos").value.split(',');
            var mArrSelectedWeights = document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value.split(',');
            var mArrPackages = document.getElementById("ctl00_MyCPH1_HidSelectedPackageNos").value.split(',');
            var mArrSelectedPackages = document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value.split(',');
            var mArrSelectedDockets = document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value.split(',');
            var mArrDockets = document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos").value.split(',');
            
            var mActualWeight;
            var mActualPackages;
            
            for(var mLoopCounter = 0; mLoopCounter < mArrSelectedWeights.length; mLoopCounter++)
            {
                mActualWeight = getActualWeight(mArrSelectedDockets[mLoopCounter]);
                mActualPackages = getActualPackage(mArrSelectedDockets[mLoopCounter]);
                
                if(eval(mActualPackages) != eval(mArrSelectedPackages[mLoopCounter]) && eval(mActualWeight) == eval(mArrSelectedWeights[mLoopCounter]))
                {
                    alert("You have changed Packages, but not changed corresponding Weight. You must change Weight too!");
                    setFocusForPackageWeight(2, mArrSelectedDockets[mLoopCounter]);
                    return false;
                }
                
                if(eval(mActualPackages) == eval(mArrSelectedPackages[mLoopCounter]) && eval(mActualWeight) != eval(mArrSelectedWeights[mLoopCounter]))
                {
                    alert("You have changed Weight, but not changed corresponding Packages. You must change Packages too!");
                    setFocusForPackageWeight(1, mArrSelectedDockets[mLoopCounter]);
                    return false;
                }
            }
            
            return true;
        }
        
        function setFocusForPackageWeight(mIndex, strDocketNo)
        {
            var mTotalRecords;
                
            if(document.getElementById("ctl00_MyCPH1_HidTotalRecords"))
            {
                mTotalRecords =  document.getElementById("ctl00_MyCPH1_HidTotalRecords").value
            }
            
            var mDerivedControlNameForPackages;
            var mDerivedControlNameForWeights;
            
            for(var mLoopCounter = 0; mLoopCounter < mTotalRecords; mLoopCounter++)
            {
                if(mLoopCounter < 10)
                {
                    mDerivedControlNameForPackages = "ctl00_MyCPH1_rptDocketListForMF_ctl" + "0" + mLoopCounter + "_txtPackagesLB"
                    mDerivedControlNameForWeights = "ctl00_MyCPH1_rptDocketListForMF_ctl" + "0" + mLoopCounter + "_txtWeightLB"
                }
                else
                {
                    mDerivedControlNameForPackages = "ctl00_MyCPH1_rptDocketListForMF_ctl" + mLoopCounter + "_txtPackagesLB"
                    mDerivedControlNameForWeights = "ctl00_MyCPH1_rptDocketListForMF_ctl" + mLoopCounter + "_txtWeightLB"
                }
                
                if(mIndex == 1)
                {
                    if(document.getElementById(mDerivedControlNameForPackages))
                    {
                        if(document.getElementById(mDerivedControlNameForPackages).DocketNo == strDocketNo)
                        {
                            document.getElementById(mDerivedControlNameForPackages).focus();
                        }
                    }
                }
                
                if(mIndex == 2)
                {
                    if(document.getElementById(mDerivedControlNameForWeights))
                    {
                        if(document.getElementById(mDerivedControlNameForWeights).DocketNo == strDocketNo)
                        {
                            document.getElementById(mDerivedControlNameForWeights).focus();
                        }
                    }
                }
            }        
        }
        
        function getActualWeight(strDocketNo)
        {
            var mArrWeights = document.getElementById("ctl00_MyCPH1_HidSelectedWeightNos").value.split(',');
            var mArrDockets = document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos").value.split(',');
            
            for(var mLoopCounter = 0; mLoopCounter < mArrWeights.length; mLoopCounter++)
            {
                if(mArrDockets[mLoopCounter] == strDocketNo)
                {
                    return mArrWeights[mLoopCounter];
                }
            }
            
            return "0"
        }
        
        function getActualPackage(strDocketNo)
        {
            var mArrPackages = document.getElementById("ctl00_MyCPH1_HidSelectedPackageNos").value.split(',');
            var mArrDockets = document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos").value.split(',');
            
            for(var mLoopCounter = 0; mLoopCounter < mArrPackages.length; mLoopCounter++)
            {
                if(mArrDockets[mLoopCounter] == strDocketNo)
                {
                    return mArrPackages[mLoopCounter];
                }
            }
            
            return "0"
        }
        
        function checkTotalPackagesWeight(objTotalPackagesWeight, mFromControl)
	    {
	        objTotalPackagesWeight.value = trimAll(objTotalPackagesWeight.value);
	        
	        var mOrgValue = objTotalPackagesWeight.OrgValue;
	        var mPackageWeight = objTotalPackagesWeight.AlertMessageKeyword;
	        
	        if(objTotalPackagesWeight.value != '')
	        {
			    if(!isNaN(objTotalPackagesWeight.value))
		        {
			        if(parseInt(objTotalPackagesWeight.value) <= 0)
			        {
				        alert('Entered ' + mPackageWeight + ' cannot be Less than Or Equal to ZERO :(');
				        objTotalPackagesWeight.value = mOrgValue;
				        objTotalPackagesWeight.focus();
				        return false;
			        }
		
			        if(parseInt(objTotalPackagesWeight.value) > mOrgValue)
			        {
				        alert('Entered ' + mPackageWeight + ' greater than Actual Pkgs!');
				        objTotalPackagesWeight.value = mOrgValue;
				        objTotalPackagesWeight.focus();
				        return false;
		        	}
			    }
			    else
			    {
				    alert('Invalid ' + mPackageWeight + '!');
				    objTotalPackagesWeight.value = mOrgValue;
				    objTotalPackagesWeight.focus();
				    return false;
			    }
		    }
		    else
		    {
			    alert(mPackageWeight + ' must be Entered!');
			    objTotalPackagesWeight.value = mOrgValue;
			    objTotalPackagesWeight.focus();
			    return false;
		    }
		    
		    if(mFromControl == '1')
		    {
		        if(document.getElementById("ctl00_MyCPH1_HidSelectedDocketNos") && document.getElementById("ctl00_MyCPH1_HidSelectedPackageNos") && document.getElementById("ctl00_MyCPH1_HidSelectedWeightNos"))
                {
                    var mArrDockets = document.getElementById("ctl00_MyCPH1_HidSelectedDockets").value.split(",");
                    var mArrPackages = document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value.split(",");
                    var mArrWeight = document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value.split(",");
                    
                    var mSelectedPackages = "";
                    var mSelectedWeight = "";
                    
                    var strDocketNo = objTotalPackagesWeight.DocketNo;
                    
                    for(var mLoopCounter = 0; mLoopCounter < mArrDockets.length; mLoopCounter++)
                    {
                        if(mArrDockets[mLoopCounter] == strDocketNo)
                        {
                            if(mPackageWeight == "Packages")
                            {
                                mSelectedPackages = (mSelectedPackages == "" ? objTotalPackagesWeight.value : mSelectedPackages + "," + objTotalPackagesWeight.value);
                            }
                            else
                            {
                                mSelectedWeight = (mSelectedWeight == "" ? objTotalPackagesWeight.value : mSelectedWeight + "," + objTotalPackagesWeight.value);
                            }
                        }
                        else
                        {
                            if(mPackageWeight == "Packages")
                            {
                                mSelectedPackages = (mSelectedPackages == "" ? mArrPackages[mLoopCounter] : mSelectedPackages + "," + mArrPackages[mLoopCounter]);
                            }
                            else
                            {
                                mSelectedWeight = (mSelectedWeight == "" ? mArrWeight[mLoopCounter] : mSelectedWeight + "," + mArrWeight[mLoopCounter]);
                            }
                        }
                    }
                    
                    if(mPackageWeight == "Packages")
                    {
                        document.getElementById("ctl00_MyCPH1_HidSelectedPackages").value = mSelectedPackages;
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_HidSelectedWeights").value = mSelectedWeight;
                    }
                }
            }
	    }
        
    </script>
    
    <div>
        
        <input type="hidden" id="HidSelectedDockets" runat="server" />
        <input type="hidden" id="HidSelectedDocketNos" runat="server" />
        <input type="hidden" id="HidSelectedToHub" runat="server" />
        <input type="hidden" id="HidDocketsNotSelected" runat="server" />
        <input type="hidden" id="HidSelectedToHubNos" runat="server" />
        <input type="hidden" id="HidSelectedPackageNos" runat="server" />
        <input type="hidden" id="HidSelectedPackages" runat="server" />
        <input type="hidden" id="HidSelectedWeightNos" runat="server" />
        <input type="hidden" id="HidSelectedWeights" runat="server" />
        <input type="hidden" id="HidSelectedDocketIDs" runat="server" />
        <input type="hidden" id="HidSelectedDocketIDNos" runat="server" />
        <input type="hidden" id="HidDocket" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
        <input type="hidden" id="HidTHC" runat="server" />
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		    
		    <tr>
			    <td>
				    <label class="blackfnt" id="lblHeader" runat="server">
				        <%--<b>
				            Update Loading Sheet & Prepare Menifest			            
				        </b>--%>
				    </label>
				    <hr align="center" size="1" color="#8ba0e5">   
			    </td>
		    </tr>
		    
		    <tr> 
			    <td>
				    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
					    <%--<tr>
						    <td style="height: 30" colspan="12">
							    <a href="../../../GUI/Operations/LSMFOptions.aspx">
							        <label class="blklnkund">
							            <b>--%>
							                <%--<%=session("Level_Type")%>--%><%-- Module
							            </b>
							        </label>
							    </a>
							    
							    <b>
							        &gt;
							    </b>
							    
							    <a href="../../../GUI/Operations/LSMFOptions.aspx">
							        <label class="blklnkund">
							            <b>
							                Operations
							            </b>
							        </label>
							    </a>
							    
							    <b>
							        &gt;
							    </b>
							    
								<asp:LinkButton ID="lnkBookOper" CssClass="blklnkund" runat="server" Text="Booking Operations" Font-Bold="true" PostBackUrl="../../../GUI/Operations/LSMFOptions.aspx" />
								<b> &gt; </b>
								<asp:LinkButton ID="lnkLSMF" CssClass="blklnkund" runat="server" Text="Loading Sheet & Manifest" Font-Bold="true" PostBackUrl="../../../GUI/Operations/LSMFOptions.aspx" />
								<b> &gt; </b>
							
							    <label class="bluefnt">
							        <b>
							            Update Loading Sheet & Prepare Menifest
							        </b>
							    </label>
						    </td>
					    </tr>
				        
					    <tr> 
						    <td align="right" colspan="12">
							    <a href="javascript:window.history.go(-1)" title="back">
							        <img src="../../../GUI/images/back.gif" border="0" />
							    </a>
						    </td>
					    </tr>--%>
					    
			            <tr>
			                <td colspan="12">
			                    <asp:UpdatePanel ID="upTable" runat="server">
			                        <ContentTemplate>
					                    <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="boxbg">
					                        <tr style="background-color: White;height: 20px;" id="trLSCaption" visible="false" runat="server">
                                                <td align="left" colspan="12" runat="server">
                                                    <label class="blackfnt">
                                                        <b>
                                                            <%=strLSCaption %>
                                                        </b>
                                                    </label>
                                                </td>
                                            </tr>
					                        
					                        <tr style="background-color: White" id="trLSCaptionWithLink" visible="false" runat="server">
                                                <td colspan="12" align="left">
                                                    <label class="blackfnt" id="lblMF" runat="server">
                                                        <%--<b>
                                                            Manifest No.&nbsp;
                                                        </b>--%>
                                                    </label>
                                                    
                                                    <asp:LinkButton ID="lnkbtnDocketsInMF" runat="server" OnClick="lnkbtnDocketsInMF_Click" CssClass="blackfnt" Font-Bold="true" Font-Underline="true">
                                                    </asp:LinkButton>
                                                    
                                                    <label class="blackfnt" id="lblDocketPrep" runat="server">
                                                        <%--<b>
                                                            &nbsp;prepared for following <%=Session["DocketCalledAs"].ToString()%>s:
                                                        </b>--%>
                                                    </label>
                                                </td>
                                            </tr>
					                        
					                        <tr class="bgbluegrey" id="trTableHeaderForMF" runat="server" visible="false">
                                                <td align="center">
                                                    <input type="checkbox" id="chkAll" runat="server" onclick="ManageAllDockets(this)" />
                                                </td>
                                                
                                                <td align="center">
                                                    <label class="blackfnt">
                                                        Sr. No.
                                                    </label>
                                                </td>
                                                
                                                <td align="left">
                                                    <label class="blackfnt" id="lblDocketCaption" runat="server">
                                                        <%--<%=Session["DocketCalledAs"].ToString()%> No.--%>
                                                    </label>
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Booking Date
                                                    </label>	
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Booking Location
                                                    </label>
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Consignor Name
                                                    </label>	
                                                </td>
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Next Stop Location
                                                    </label>
                                                </td>
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Delivery Location
                                                    </label>	
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Arrival Date
                                                    </label>	
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Delivery Date
                                                    </label>	
                                                </td>	
                                                
                                                <td align="right">
                                                    <label class="blackfnt">
                                                        Packages L/B
                                                        &nbsp;
                                                    </label>	
                                                </td>	
                                                
                                                <td align="right">
                                                    <label class="blackfnt">
                                                        Weight L/B
                                                        &nbsp;
                                                    </label>	
                                                </td>
                                            </tr>
                                            
                                            <asp:Repeater ID="rptDocketListForMF" runat="server" Visible="false">
                                                <ItemTemplate>
                                                    <tr style="background-color: White">
                                                        <td align="center">
                                                            <input id="chkSelDocket" type="checkbox" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "DocketNo")%>' 
                                                                DocketMode='<%#DataBinder.Eval(Container.DataItem, "DocketNo")%>' 
                                                                GiveAlert='<%#DataBinder.Eval(Container.DataItem, "GiveAlert")%>' 
                                                                DelyLoc='<%#DataBinder.Eval(Container.DataItem, "DelyLoc")%>' 
                                                                onclick="SelectDocket(this)" />
                                                        </td>
                                                        
                                                        <td align="center">
                                                            <label class="blackfnt" style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt" style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "OrgCode")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">                                                                                                        
                                                                <%#DataBinder.Eval(Container.DataItem, "ConsName")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "NextStop")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DelyLoc")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "ArrivalDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DelyDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left" nowrap>
                                                            <input type="text" id="txtPackagesLB" runat="server" 
                                                                class="input" size="4" maxlength="8" value='<%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>' 
                                                                OrgValue='<%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>' 
                                                                DocketNo='<%#DataBinder.Eval(Container.DataItem, "DocketNo")%>' 
                                                                AlertMessageKeyword="Packages" onblur="return checkTotalPackagesWeight(this, '1')" 
                                                                 />
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                /<%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left" nowrap>
                                                            <input type="text" id="txtWeightLB" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                                                class="input" size="4" maxlength="8" OrgValue='<%#DataBinder.Eval(Container.DataItem, "WeightLB")%>'  
                                                                DocketNo='<%#DataBinder.Eval(Container.DataItem, "DocketNo")%>' 
                                                                AlertMessageKeyword="Weight" onblur="return checkTotalPackagesWeight(this, '1')"
                                                                 />
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                /<%#DataBinder.Eval(Container.DataItem, "WeightLB")%>
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            
                                            <tr class="bgbluegrey" id="trTableHeaderForMFForView" runat="server" visible="false">
                                                <td id="td1" runat="server">
                                                    &nbsp;
                                                </td>
                                                
                                                <td align="center">
                                                    <label class="blackfnt">
                                                        Sr. No.
                                                    </label>
                                                </td>
                                                
                                                <td align="left">
                                                    <label class="blackfnt" id="lblDocketCaption1" runat="server">
                                                        <%--<%=Session["DocketCalledAs"].ToString()%> No.--%>
                                                    </label>
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Booking Date
                                                    </label>	
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Booking Location
                                                    </label>
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Consignor Name
                                                    </label>	
                                                </td>
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Next Stop Location
                                                    </label>
                                                </td>
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Delivery Location
                                                    </label>	
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Arrival Date
                                                    </label>	
                                                </td>	
                                                
                                                <td align="left">
                                                    <label class="blackfnt">
                                                        Delivery Date
                                                    </label>	
                                                </td>	
                                                
                                                <td align="right">
                                                    <label class="blackfnt">
                                                        Packages L/B
                                                        &nbsp;
                                                    </label>	
                                                </td>	
                                                
                                                <td align="right">
                                                    <label class="blackfnt">
                                                        Weight L/B
                                                        &nbsp;
                                                    </label>	
                                                </td>
                                            </tr>
                                            
                                            <asp:Repeater ID="rptViewDocketsInMF" runat="server" Visible="false">
                                                <ItemTemplate>
                                                    <tr style="background-color: White">
                                                        <td align="center">
                                                            <label class="blackfnt" style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt" style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "OrgCode")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">                                                                                                        
                                                                <%#DataBinder.Eval(Container.DataItem, "ConsName")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "NextStop")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DelyLoc")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "ArrivalDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "DelyDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="right">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>
                                                                &nbsp;
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="right">
                                                            <label class="blackfnt"  style="color: <%#DataBinder.Eval(Container.DataItem, "RowColor")%>">
                                                                <%#DataBinder.Eval(Container.DataItem, "WeightLB")%>
                                                                &nbsp;
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            
                                            <input type="hidden" id="HidTotalRecords" runat="server" />
                                            <input type="hidden" id="HidLSNo" runat="server" />
                                                
                                            <tr style="background-color: White" runat="server" id="trPrepareMFButton" visible="false">
                                                <td colspan="12" align="center">
                                                    <br style="font-size: 4pt;"/>
                                                    <asp:Button ID="btnPrepareMF" runat="server" OnClientClick="return CheckDocketSelection();" 
                                                        OnClick="btnPrepareMF_Click" />
                                                </td>
                                            </tr>
                                            
                                            <tr style="background-color: White" runat="server" id="trErrorMsgForMF" visible="false">
                                                <td colspan="12" align="left">
                                                    <label runat="server" class="blackfnt" style="color: Red;" id="lblErrorMsgForMF">
                                                    </label>
                                                </td>
                                            </tr>
                                            
                                            <%--<tr style="background-color: White" runat="server" id="trNextStep" visible="false">
                                                <td colspan="12" align="left">
                                                    <label class="blackfnt">
                                                        <b>
                                                            Your Next Step:
                                                        </b>
                                                    </label>
                                                </td>
                                            </tr>--%>
                                            
                                            <%--<tr style="background-color: White" runat="server" id="trPrepareMF" visible="false">
                                                <td colspan="12" align="left">
                                                    <label class="blackfnt">
                                                        <a href="./ListLoadingSheet.aspx">
                                                            <u>
                                                                Click here to prepare Manifest
                                                            </u>
                                                        </a>
                                                    </label>
                                                </td>
                                            </tr>
                                            
                                            <tr style="background-color: White" runat="server" id="trPrepareTHC" visible="false">
                                                <td colspan="12" align="left">
                                                    <label class="blackfnt">
                                                        <a href="../../../GUI/Operations/THC/THCMain.aspx">
                                                            <u>
                                                                Click here to prepare THC
                                                            </u>
                                                        </a>
                                                    </label>
                                                </td>
                                            </tr>--%>
					                    </table>
					                    
					                    <center>
					                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressArea">
                                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
					                    </center>
					                    
				                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnPrepareMF" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
					        </td>
					    </tr>
                    </table>
                </td>
            </tr>
        </table>
        
    </div>
        
</asp:Content>

