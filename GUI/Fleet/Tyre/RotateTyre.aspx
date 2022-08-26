<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="RotateTyre.aspx.cs" Inherits="TYRE1_MountTyre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript">
  
    function func()
    {
    }
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkVehNo(txtVehNo,hfVehIntId,txtKm)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtVehNo.value == "")
        {
            txtVehNo.value="";
            hfVehIntId.value="";
            txtKm.value="";
            return;
        }

        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        alert("Invalid Vehicle Number");
                        txtVehNo.value="";
                        hfVehIntId.value="";
                        txtKm.value="";
                        txtVehNo.focus();
                    }
                    else
                    {
                        txtVehNo.value=returnValue[1];
                        hfVehIntId.value=returnValue[2];
                        txtKm.value=returnValue[3];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidVehNoRotate&datetime="+currentTime+"&VehNo=" + txtVehNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function CheckTyrePosFront(row_Index,ddlNewTyrePos,hfTyrePosAllowed,hfTyreId,hfTyreCategory)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";

        if (ddlNewTyrePos.value == "0")
        {
            return;
        }
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTyreRoate").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (row_Index == intIndex - 2)
            {
                continue;
            }
            if (document.getElementById("ctl00_MyCPH1_gvTyreRoate_ctl" + str_Index + "_ddlNewTyrePos").value == ddlNewTyrePos.value)
            {
                alert("This Part already exist at row " + (intIndex - 1));
                ddlNewTyrePos.value = "0";
                ddlNewTyrePos.focus();
                return;
            }
        }
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if(hfTyreCategory.value!="Remould")
                    {
                        if (returnValue[0] == "N") 
                        {
                        }
                        else
                        {
                            alert("Rear Tyre can not be put in the front !!! ");
                            ddlNewTyrePos.value="0";
                            ddlNewTyrePos.focus();
                        }
                    }
                    else
                    {
                        if (returnValue[0] == "N") 
                        {
                        }
                        else
                        {
                            alert("Remould tyre can not be put in front  !!! ");
                            ddlNewTyrePos.value="0";
                            ddlNewTyrePos.focus();
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckTyrePosFront&datetime="+currentTime+"&TyrePosId="+ddlNewTyrePos.value+"&TyreId="+hfTyreId.value+"&TyreCategory="+hfTyreCategory.value+"&TyrePosAllowed="+hfTyrePosAllowed.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }
    }
    function CheckValidShow()
    {
        if(document.getElementById("<%=txtVehNo.ClientID %>").value =="")
        {
            alert("Enter Vehicle Number!!!");
            document.getElementById("<%=txtVehNo.ClientID %>").focus();
            return false;
        }
        if(document.getElementById("<%=txtDate.ClientID %>").value=="") 
        {
            alert("Enter Date!!!");
            document.getElementById("<%=txtDate.ClientID %>").focus();
            return false;
        }
    }
   
    function CheckValid()
    {
        var gvTyreRoate = document.getElementById("ctl00_MyCPH1_gvTyreRoate");
        if(gvTyreRoate.rows.length != 0)
        {
            var count=0; 
            for (intIndex = 2; intIndex <= gvTyreRoate.rows.length; intIndex++)
            {
                if (intIndex < 10)
                {
                    str_Index = "0" + intIndex;
                }
                else
                {
                    str_Index = intIndex;
                }
                var ddlNewTyrePos = document.getElementById("ctl00_MyCPH1_gvTyreRoate_ctl" + str_Index + "_ddlNewTyrePos");
                var hfCurrentTyrePos = document.getElementById("ctl00_MyCPH1_gvTyreRoate_ctl" + str_Index + "_hfCurrentTyrePos");
                var lblCurrentTyrePos = document.getElementById("ctl00_MyCPH1_gvTyreRoate_ctl" + str_Index + "_lblCurrentTyrePos");
                var hfTyrePosAllowed = document.getElementById("ctl00_MyCPH1_gvTyreRoate_ctl" + str_Index + "_hfTyrePosAllowed");
                
                if(ddlNewTyrePos.value != "0")
                {
                    //alert("Select New Tyre Position");
                    count=count+1;
                    //ddlNewTyrePos.focus();
                    //return false;
                }
               
                if(ddlNewTyrePos.value == hfCurrentTyrePos.value)
                {
                    alert("Kindly Change the Tyre Position!!!")
                    ddlNewTyrePos.focus();
                    return false;
                }
                if(ddlNewTyrePos.value == lblCurrentTyrePos.innerText)
                {
                    alert("Current Tyre Position and New Tyre Position must be different!!!")
                    ddlNewTyrePos.focus();
                    return false;
                }
            }
            if(count == 0)
           {
                alert("You must have change atleast one position.");
                return false;
           } 
        }
    }
    
    function ValidateDate(obj) 
    {
        if (obj.value != "") 
        {
            if (isDate(obj.value) == false) 
            {
                obj.focus();
                return false;
            }
            return true;
        }
    }
    var dtCh = "/";
    var minYear = "1900";
    var maxYear = "2100";
    function DaysArray(n)
    {
        for (var i = 1; i <= n; i++) 
        {
            this[i] = 31
            if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
            if (i == 2) { this[i] = 29 }
        }
        return this;
    }
    function isDate(dtStr) 
    {
        var daysInMonth = DaysArray(12)
        var pos1 = dtStr.indexOf(dtCh)
        var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
        var strDay = dtStr.substring(0, pos1)
        var strMonth = dtStr.substring(pos1 + 1, pos2)
        var strYear = dtStr.substring(pos2 + 1)
        strYr = strYear
        if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
        if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
        for (var i = 1; i <= 3; i++) {
            if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
        }

        month = parseInt(strMonth)
        day = parseInt(strDay)
        year = parseInt(strYr)
        if (pos1 == -1 || pos2 == -1) {
            alert("The date format should be : dd/mm/yyyy");
            return false;
        }
        if (strMonth.length < 1 || month < 1 || month > 12) {
            alert("Please enter a valid month");
            return false;
        }
        if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
            alert("Please enter a valid day");
            return false;
        }
        if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
            alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear);
            return false;
        }

        if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
            alert("Please enter a valid date");
            return false;
        }
        return true;
    }
   
</script>
<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table cellspacing="1" style="width: 100%">
            <tr style="background-color: white">
                <td align="left" style="font-weight: bold; vertical-align: top; color: #006633; height: 3px;
                    text-align: left">
                    <br />
                    TYRE ROTATION<br />
                    <hr />
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="vertical-align: top; text-align: left">
                    <table cellspacing="1" class="boxbg" style="width: 60%">
                        <tr style="background-color: white">
                            <td align="right" style="width: 25%; text-align: left">
                            </td>
                            <td align="left" colspan="2" style="width: 75%; text-align: right">
                                <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" ForeColor="Blue"
                                    NavigateUrl="~/GUI/Fleet/Document/DownloadFile.aspx?FileName=AGL_000577.xls"
                                    Target="_blank">Click here for Tire Rotation Help</asp:HyperLink></td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" style="width: 25%; text-align: left">
                <asp:Label ID="Label1" runat="server" Text="Enter Vehicle Number:"></asp:Label></td>
                            <td align="left" colspan="2" style="width: 75%">
                <asp:TextBox ID="txtVehNo" runat="server" Width="140px" AutoCompleteType="Notes"></asp:TextBox>
                <asp:Button ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
                <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtVehNo"
                ServicePath="~/GUI/services/WebService.asmx" 
                ServiceMethod="GetVehNo"
                MinimumPrefixLength="1" 
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="20"
                CompletionListCssClass="autocomplete_completionListElement" 
                CompletionListItemCssClass="autocomplete_listItem" 
                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                DelimiterCharacters=";, :"
                ShowOnlyCurrentWordInCompletionListItem="true" >               
                <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
                
                
                <asp:HiddenField ID="hfVehIntId" runat="server" />
                <asp:HiddenField ID="hfVehcate" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" style="width: 25%; text-align: left">
                                <asp:Label ID="Label3" runat="server" Text="Current KM. :"></asp:Label></td>
                            <td align="left" colspan="2" style="width: 75%">
                                <asp:TextBox ID="txtKm" runat="server" Width="59px"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" style="width: 25%; text-align: left">
                <asp:Label ID="Label2" runat="server" Text="Select Date:"></asp:Label></td>
                            <td align="left" colspan="2" style="width: 75%">
                <asp:TextBox ID="txtDate" runat="server" BorderStyle="Groove" Columns="6" CssClass="input"
                    MaxLength="10" Text='<%#Eval("RemouldDate")%>' Width="60px" onblur= "javascript:ValidateDate(this)"></asp:TextBox>
                    <%--<asp:Image ID="img_Calendar" runat="server" BackColor="White" BorderColor="White" ForeColor="White"
                        ImageUrl="~/cal/cal.gif" />--%>
                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtDate" runat="server" />
                        </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" colspan="3">
                <asp:Button ID="btnShow" OnClientClick="javascript:return CheckValidShow()"  runat="server" Text="Show" OnClick="btnShow_Click" /></td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" colspan="3" style="width: 100%; text-align: left">
                <asp:GridView ID="gvTyreRoate" runat="server" AutoGenerateColumns="False" CellPadding="5" Width="100%" OnRowDataBound="gvTyreRoate_RowDataBound" EmptyDataText="No Record Found..." CssClass="dgRowStyle">
                    <Columns>
                        <asp:TemplateField HeaderText="Tyre No">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TYRE_ID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTyreNo" runat="server" Text='<%# Bind("TYRE_No") %>'></asp:Label>
                                <asp:HiddenField ID="hfTyreId" runat="server" Value='<%# Bind("TYRE_ID") %>' />
                                <asp:HiddenField ID="hfTyreCategory" runat="server" Value='<%# Bind("TYRE_CATEGORY") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:TemplateField HeaderText="Tread Depth">
                            <EditItemTemplate>
                                <asp:TextBox ID="tb_Tread_Depth" runat="server" Text='<%# Bind("TYRE_TREAD_DEPTH_32NDS") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_Tread_Depth" runat="server" Text='<%# Bind("TYRE_TREAD_DEPTH_32NDS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Current Tyre Position">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TYREPOS_CODE") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCurrentTyrePos" runat="server" Text='<%# Bind("TYREPOS_CODE") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Current Tyre Position">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlNewTyrePos" runat="server"  Width="122px">
                                </asp:DropDownList>
                                <asp:HiddenField ID="hfCurrentTyrePos" runat="server" />
                                 <asp:HiddenField ID="hfTyrePosAllowed" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                    </Columns>
                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" colspan="3" style="width: 100%; text-align: right">
                <asp:Button ID="btnSubmit" OnClientClick="javascript:return CheckValid()"  runat="server" Text="Submit" OnClick="btnSubmit_Click" Visible="False" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left">
                </td>
            </tr>
        </table>
  
</ContentTemplate>
    
    </asp:UpdatePanel>
    <br />
    <br />
    &nbsp;<br />
    <br />
  
</asp:Content>
