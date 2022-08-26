<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Tyre.aspx.cs" Inherits="GUI_Fleet_Webadmin_Tyre_Tyre" Title="Tyre Master" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
   <script type="text/javascript" language="JavaScript" src="../../../Js/querystring.js"></script>
   <script type="text/javascript" language="javascript" src="../../../Js/Date.js"></script>
  <script language="javascript">
   
   function validFloat(event, txtid) {
    var tb = document.getElementById(txtid);
    var txt = tb.value;
    if (event.keyCode == 13)
        return true;

    if (event.keyCode == 46)
        if (txt.indexOf('.') != -1)
        event.keyCode = 0;

    if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
    { event.keyCode = 0; return false; }
} 

  
    function funPageLoad()
    {
      
    }
   
    function checkVehNo()
    {
        var OEMSA=""
        if(document.getElementById("ctl00$MyCPH1$RadioButtonList1").checked==true)
        {
            OEMSA="1"
        }
        else
        {
            OEMSA="2"
        }
    
        if(OEMSA=="1")
        {
            var currentTime = new Date()
            //alert(currentTime);
            var ConnStr="<%= Session["SqlProvider"] %>";
            var str_Index = "";
            if (document.getElementById("ctl00_MyCPH1_txtVehNo").value == "")
            {
                document.getElementById("ctl00_MyCPH1_txtVehNo").value="";
                document.getElementById("ctl00_MyCPH1_hfVehIntId").value="";
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
                            document.getElementById("ctl00_MyCPH1_txtVehNo").value="";
                            document.getElementById("ctl00_MyCPH1_hfVehIntId").value="";
                            document.getElementById("ctl00_MyCPH1_txtVehcat").value="";
                            document.getElementById("ctl00_MyCPH1_txtVehNo").focus();
                        }
                        else
                        {
                            document.getElementById("ctl00_MyCPH1_txtVehNo").value=returnValue[1];
                            document.getElementById("ctl00_MyCPH1_hfVehIntId").value=returnValue[2];
                            if(returnValue[3]=="")
                            {
                                alert("There is no 'Vehicle Category' present in the selected vehicle number!!!\n Please check in the vehicle type master.")
                                document.getElementById("ctl00_MyCPH1_txtVehNo").value="";
                                document.getElementById("ctl00_MyCPH1_txtVehNo").focus();
                                return;
                            }
                            else
                            {
                                document.getElementById("ctl00_MyCPH1_txtVehcat").value=returnValue[3];
                            }
                        }
                    }
                }
                xmlHttpRequest.open("GET", "../../../Fleet/Tyre/wfrm_AJAX_Validator.aspx?Function=CheckValidVehNoTyreMst&datetime="+currentTime+"&VehNo=" + document.getElementById("ctl00_MyCPH1_txtVehNo").value+"&ConnStr="+ConnStr, false);
                xmlHttpRequest.send(null);
            }
        }	
    }
 
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkTyreNo(txtTyreNo)
    {
    
        var qs = new Querystring()
        var qTyreid = qs.get("Id")
    
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        
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
                       txtTyreNo.value=txtTyreNo.value;
                    }
                    else
                    {
                        alert("Tyre No is Already Exist !");
                        txtTyreNo.value="";
                        txtTyreNo.focus();
                    }
                }
            }
            xmlHttpRequest.open("GET", "../../../Fleet/Tyre/wfrm_AJAX_Validator.aspx?Function=CheckValidTyreNo&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value+"&TyreId="+qTyreid+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function checkValidation()
    {
        var OEMSA=""
        if(document.getElementById("ctl00$MyCPH1$RadioButtonList1").checked==true)
        {
            OEMSA="1"
        }
        if(document.getElementById("ctl00$MyCPH1$RadioButtonList1").checked==false)
        {
            OEMSA="2"
        }
//        else
//        {
//            OEMSA="2"
//        }
        
        //var OEMSA = document.getElementById("ctl00_MyCPH1_RadioButtonList1").getAttribute("SelectedValue")
        //alert(OEMSA)
        var no = document.getElementById("ctl00_MyCPH1_txtTyreNo").value;
        if(no=="")
        {
            alert("Please Enter Tyre No!")
            document.getElementById("ctl00_MyCPH1_txtTyreNo").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
        var tyrecategory= document.getElementById("ctl00_MyCPH1_ddlTyreCategory").value;
        if(tyrecategory=="0")
        {
            alert("Select Tyre Category!")
            document.getElementById("ctl00_MyCPH1_ddlTyreCategory").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
        var mfg = document.getElementById("ctl00_MyCPH1_ddlManufacturer").value; 
        if(mfg=="0")
        {
            alert("Select Manufacturer!")
            document.getElementById("ctl00_MyCPH1_ddlManufacturer").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
        var model = document.getElementById("ctl00_MyCPH1_ddlTyreModel").value; 
        if(model=="0")
        {
            alert("Select Manufacturer!")
            document.getElementById("ctl00_MyCPH1_ddlTyreModel").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
        var size= document.getElementById("ctl00_MyCPH1_ddlSize").value;
        if(size=="0")
        {
            alert("Select Tyre Size!")
            document.getElementById("ctl00_MyCPH1_ddlSize").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
        var pattern= document.getElementById("ctl00_MyCPH1_ddlTyrePattern").value;
        if(pattern=="0")
        {
            alert("Select Tyre Pattern!")
            document.getElementById("ctl00_MyCPH1_ddlTyrePattern").focus()
            return false;
        }
//        var pattern = document.getElementById("ctl00_MyCPH1_txtDispPattern").value;
//        if(pattern=="")
//        {
//            alert("Enter Tyre Pattern!")
//            document.getElementById("ctl00_MyCPH1_txtDispPattern").focus()
//            return false;
//        }
        //////////////////////////////////////////////////////////////
        var treadDepth=document.getElementById("ctl00_MyCPH1_txtTreadDepth").value;  
        if(treadDepth=="")
        {
            alert("Enter Tread Depth!")
            document.getElementById("ctl00_MyCPH1_txtTreadDepth").focus()
           return false;
        }
        ////////////////////////////////////////////////////////////////////////
        var PurDt=document.getElementById("ctl00_MyCPH1_txtPurchaseDate").value;  
        if(PurDt=="")
        {
            alert("Enter Purchase Date!")
            document.getElementById("ctl00_MyCPH1_txtPurchaseDate").focus();
            return false;
        }
        else
        {
            if(!isDate(PurDt,"dd/mm/yyyy"))
            {
                alert("Please Enter Valid date !!!");
                document.getElementById("ctl00_MyCPH1_txtPurchaseDate").focus();
                return false;
            }
        }
        ////////////////////////////////////////////////////////////////////////
        var PurKm=document.getElementById("ctl00_MyCPH1_txtPurchaseKM").value;  
        if(PurKm=="")
        {
            alert("Enter Purchase KM!")
            document.getElementById("ctl00_MyCPH1_txtPurchaseKM").focus()
            return false;
        }
        if(isNaN(PurKm))
        {
            alert("Please Enter Purchase Kms in numeric !");
            document.getElementById("ctl00_MyCPH1_txtPurchaseKM").value="";
            document.getElementById("ctl00_MyCPH1_txtPurchaseKM").focus()
            return false;
        }
        ///////////////////////////////////////////////////////////////
        var cost=document.getElementById("ctl00_MyCPH1_txtCost").value;
        if(cost=="")
        {
            alert("Enter Tyre Cost!")
            document.getElementById("ctl00_MyCPH1_txtCost").focus()
            return false;
        }
        if(isNaN(cost))
        {
            alert("Please Enter Cost in numeric !");
            document.getElementById("ctl00_MyCPH1_txtCost").value="";
            document.getElementById("ctl00_MyCPH1_txtCost").focus()
            return false;
        }
        ///////////////////////////////////////////////////////////////
        //alert(OEMSA);
        if(OEMSA == "1")
        {
            var vehicleno = document.getElementById("ctl00_MyCPH1_txtVehNo").value;
            if(vehicleno=="")
            {
                alert("Enter Vehicle Number!")
                document.getElementById("ctl00_MyCPH1_txtVehNo").focus()
                return false;
            }
            var positionCate= document.getElementById("ctl00_MyCPH1_ddlTyrePosCategory").value;
            if(positionCate=="0")
            {
                alert("Select Tyre Position Category!")
                document.getElementById("ctl00_MyCPH1_ddlTyrePosCategory").focus()
                return false;
            }
            //////////////////////////////////////////////////////////////
            var position= document.getElementById("ctl00_MyCPH1_ddlTyrePosition").value;
            if(position=="0")
            {
                alert("Select Tyre Position!")
                document.getElementById("ctl00_MyCPH1_ddlTyrePosition").focus()
                return false;
            }
            //////////////////////////////////////////////////////////////
       
        }
        ///////////////////////////////////////////////////////////////
        var type = document.getElementById("ctl00_MyCPH1_ddlTyreType").value;
        if(type=="00")
        {
            alert("Select Tyre Type!")
            document.getElementById("ctl00_MyCPH1_ddlTyreType").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
       
        if(OEMSA == "2")
        {
            var location= document.getElementById("ctl00_MyCPH1_ddlLocation").value;
            //alert(location)
            if(location=="0")
            {
                alert("Select Location!")
                document.getElementById("ctl00_MyCPH1_ddlLocation").focus()
                return false;
            }
            ///////////////////////////////////////////////////////////////////////
            var vendor=document.getElementById("ctl00_MyCPH1_ddlVendor").value;  
           // alert(vendor)
            if(vendor=="0")
            {
                alert("Select Vendor!")
                document.getElementById("ctl00_MyCPH1_ddlVendor").focus()
                return false;
            }
        }
    }
    //function check1(TextBox1)
    ///{
    //    TextBox1.value=TextBox1.value.toUpperCase();
    ///}
</script>

 <asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>
  
     <asp:UpdatePanel ID="UPSelectTyre" runat="server" RenderMode="Inline">
     <ContentTemplate>

      <table cellspacing="1" cellpadding="5" class="boxbg" border="0" style="width: 60%; font-size: 8pt; font-family: Verdana;" >
        <br />
          <asp:Label ID="lblHeader" runat="server" Font-Bold="True" Text="Tyre Details"></asp:Label><tr style="background-color: white">
            
        </tr>
             <br />
     </table>
   
    <table cellspacing="1" cellpadding="3" class="boxbg" border="0" style="width: 60%; font-size: 8pt; font-family: Verdana;" >
      
        <tr style="background-color: white">
            <td align="left" style="width: 15%; height: 14px" valign="top">
                Select Tyre</td>
            <td align="left" valign="top" colspan="3">
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                            RepeatDirection="Horizontal" Width="100%" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="True">
                            <asp:ListItem Value="0" Text="OEM" ></asp:ListItem>
                            <asp:ListItem Value="1" Text="STAND ALONE"></asp:ListItem>
                        </asp:RadioButtonList></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label1" runat="server" Text="Tyre No.:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top">
                <asp:TextBox ID="txtTyreNo" runat="server" CssClass="input"></asp:TextBox>
              
                </td>
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="lblCategory" runat="server" Text="Tyre Category:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top"><asp:DropDownList ID="ddlTyreCategory" runat="server" CssClass="input" Width="121px" AutoPostBack="True" OnSelectedIndexChanged="ddlTyreCategory_SelectedIndexChanged">
            </asp:DropDownList></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label5" runat="server" Text="Manufacturer:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:DropDownList ID="ddlManufacturer" runat="server" CssClass="input" Width="121px" AutoPostBack="True" OnSelectedIndexChanged="ddlManufacturer_SelectedIndexChanged">
            </asp:DropDownList></td>
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label14" runat="server" Text="Tyre Model:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:DropDownList ID="ddlTyreModel"  AutoPostBack="true"  runat="server" CssClass="input" Width="121px" OnSelectedIndexChanged="ddlTyreModel_SelectedIndexChanged">
            </asp:DropDownList></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label3" runat="server" Text="Tyre Size:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top">
                <asp:DropDownList ID="ddlSize" runat="server" CssClass="input" Width="121px">
                </asp:DropDownList></td>
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label4" runat="server" Text="Tyre Pattern:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top"><asp:DropDownList ID="ddlTyrePattern" runat="server" CssClass="input" Width="121px">
            </asp:DropDownList></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label15" runat="server" Text="Average TWI:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:TextBox ID="txtTreadDepth" runat="server" Width="107px"></asp:TextBox>
                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="32nds"></asp:Label></td>
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label10" runat="server" Text="Purchase Date:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="input" Width="98px"></asp:TextBox>
                <%--<asp:Image id="img_CalendarDate" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:Image>--%>
                      <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtPurchaseDate"   runat="server" />

                </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label11" runat="server" Text="Purchase KM:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:TextBox ID="txtPurchaseKM" runat="server" CssClass="input"></asp:TextBox></td>
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label12" runat="server" Text="Cost:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:TextBox ID="txtCost" runat="server" CssClass="input"></asp:TextBox></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label7" runat="server" Text="Vehicle No.:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:TextBox ID="txtVehNo" runat="server" AutoCompleteType="Notes" Width="130px"></asp:TextBox><asp:Button
                    ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
                  
                     <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtVehNo"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
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
              
            </td>
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label9" runat="server" Text="Vehicle Category:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:TextBox ID="txtVehcat" runat="server" CssClass="input" Width="70px"></asp:TextBox></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%" valign="top">
                <asp:Label ID="Label6" runat="server" Text="Tyre Type:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top">
                <asp:DropDownList ID="ddlTyreType" runat="server" CssClass="input" Width="121px">
            </asp:DropDownList></td>
            <td align="left" style="width: 15%" valign="top">
            </td>
            <td align="left" style="width: 25%" valign="top">
            </td>
        </tr>
        <tr style="background-color: white" runat="server" id="rPos">
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label8" runat="server" Text="Position Category:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top"><asp:DropDownList ID="ddlTyrePosCategory" runat="server" CssClass="input" Width="121px" AutoPostBack="True" OnSelectedIndexChanged="ddlTyrePosCategory_SelectedIndexChanged">
            </asp:DropDownList></td>
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label16" runat="server" Text="Position:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top"><asp:DropDownList ID="ddlTyrePosition" runat="server" CssClass="input" Width="121px">
            </asp:DropDownList></td>
        </tr>
        
        <tr style="background-color: white" runat="server" id="Tr1">
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label17" runat="server" Text="Tyre weight:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top">
                <asp:TextBox ID="txtTyre_Weight" runat="server" CssClass="input" Width="70px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
            </td>
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label18" runat="server" Text="Outer Dimension:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top">
                <asp:TextBox ID="txtOuter_Dimention" runat="server" CssClass="input" Width="70px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
            </td>
        </tr>
       
        <tr style="background-color: white" runat="server" id="rLocVen">
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="lblLocation" runat="server" Text="Location:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top"><asp:DropDownList ID="ddlLocation" runat="server" CssClass="input" Width="121px">
            </asp:DropDownList></td>
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="lblVendor" runat="server" Text="Vendor:"></asp:Label></td>
            <td align="left" style="width: 25%" valign="top"><asp:DropDownList ID="ddlVendor" runat="server" CssClass="input" Width="121px">
            </asp:DropDownList></td>
        </tr>
        <tr style="background-color: white" runat="server" id="WarrentyRow">
            <td align="left" style="width: 15%;" valign="top">
                <asp:DropDownList ID="ddlSelectCat" runat="server" Width="125px" Font-Size="8pt" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectCat_SelectedIndexChanged" BackColor="White">
                </asp:DropDownList>
            </td>
            <td align="left" style="width: 25%;" valign="top" >
                <asp:TextBox ID="txtWarrenyExpireDate" runat="server"  Width="100px"  MaxLength="10" BorderStyle="Groove" CssClass="input"></asp:TextBox>
                 <%--<asp:Image id="img_Calendar" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:Image>--%>
                       <ajaxToolkit:CalendarExtender ID="CalendarExtender1" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtWarrenyExpireDate"   runat="server" />

                <asp:TextBox ID="txtKms" runat="server" CssClass="input" Width="97px"></asp:TextBox></td>
            <td align="left" style="width: 15%;" valign="top">
                </td>
            <td align="left" style="width: 25%;" valign="top">
                </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 15%;" valign="top">
                <asp:Label ID="Label13" runat="server" Text="Active Flag:"></asp:Label></td>
            <td align="left" style="width: 25%;" valign="top">
                <asp:DropDownList ID="ddlActive" runat="server" Width="65px">
                    <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
                </asp:DropDownList></td>
            <td align="left" style="width: 15%;" valign="top">
                </td>
            <td align="left" style="width: 25%;" valign="top">
                &nbsp;</td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="4" style="height: 32px; text-align: right" valign="top">
                <br />
                <br />
                &nbsp;<asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return checkValidation()" OnClick="btnSubmit_Click" Text="Submit" /></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="4" style="text-align: center" valign="top">
                <asp:Label ID="lbl_Page_Error" runat="server"></asp:Label></td>
        </tr>
    </table>

</ContentTemplate>
</asp:UpdatePanel>

</asp:Content>

