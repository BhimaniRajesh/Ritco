<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GeneralizePO.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POGeneration_GeneralizePO" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl_FA.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="JavaScript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>

    <script type="text/javascript" language="javascript" src="../FA.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    frm_name="ctl00$MyCPH1$"
        User_CTR_Frm_Name="ctl00$MyCPH1$UCMyPaymentControl1$"
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var FinYear="<%=Session["FinYear"]%>";
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
    		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
	    function nwOpen()
        {
            window.open("popupven.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
	    function nwOpen2(m1,m2)
        {        
            window.open("popupasset.aspx?cd=" + m1+"&nm="+m2,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }        
	 
        function Check_Calc()
        {          
            FRM_Name="ctl00$MyCPH1$"
            Total_Grid_ROW=document.getElementById(FRM_Name+"txtRows").value
            if(Total_Grid_ROW=="")
            {
                Total_Grid_ROW="5"
            }
            var Qty,Tax,Rate,Total="0",TotalNetamt="0",Total_Qty="0",TaxAmt="0";
            var Assetcd
            var ddlMatCat;
            for(var i=0;i<Total_Grid_ROW;i++)
            {        
                j=i+2
                if(j<10)
                {
                    GV_Frm_Name="ctl00_MyCPH1_GV_Details_ctl0"+j+"_";
                }
                else
                {
                    GV_Frm_Name="ctl00_MyCPH1_GV_Details_ctl"+j+"_"; 
                }
                Qty=document.getElementById(GV_Frm_Name+"txtqty").value
                Tax=document.getElementById(GV_Frm_Name+"txtperct").value
                TaxAmt=document.getElementById(GV_Frm_Name+"txtperctAmt").value
                Rate=document.getElementById(GV_Frm_Name+"txtrate").value
                Total=document.getElementById(GV_Frm_Name+"txttot").value
                Discount=document.getElementById(GV_Frm_Name+"txtDiscount").value
                DiscountAmt=document.getElementById(GV_Frm_Name+"txtDiscountAmt").value
                
                
                ddlMatCat=document.getElementById("ctl00_MyCPH1_ddlMatCat");
                if(ddlMatCat.value=="01")
                {
                    Assetcd=document.getElementById(GV_Frm_Name+"txtPackMaterial").value               
                }
                else if (ddlMatCat.value=="02")
                {
                    Assetcd=document.getElementById(GV_Frm_Name+"txtTyreModel").value
                }
                else if (ddlMatCat.value=="03")
                {
                    Assetcd=document.getElementById(GV_Frm_Name+"txtSparePart").value
                }
                else if (ddlMatCat.value=="04")
                {
                    Assetcd=document.getElementById(GV_Frm_Name+"txtGeneral").value
                }
                else if (ddlMatCat.value=="5" || ddlMatCat.value=="05")
                {
                    Assetcd=document.getElementById(GV_Frm_Name+"txtStationary").value
                }
                else if (ddlMatCat.value=="6" || ddlMatCat.value=="06")
                {
                    Assetcd=document.getElementById(GV_Frm_Name+"txtFixAsset").value
                }
                else
                {
                    Assetcd="";
                }                
                if (Assetcd!="")
                {
                    if(parseFloat(Qty)>0 && parseFloat(Rate)>0 )
                    {                        
                       // debugger;
                        var Tax1="0",Discount1="0",Total_Discount="0";
                        Total=parseFloat(Qty)*parseFloat(Rate)
                        
                        Discount1=(parseFloat(roundNumber(Total,2)) * Discount / 100)
                        Total_Discount=parseFloat(roundNumber(Total,2)) - parseFloat(roundNumber(Discount1,2))
                        Tax1=((parseFloat(roundNumber(Total_Discount,2))*parseFloat(Tax))/100)
                        Total = Total - Discount1 + Tax1
                        document.getElementById(GV_Frm_Name+"txtDiscountAmt").value=parseFloat(roundNumber(Discount1,2))
                        document.getElementById(GV_Frm_Name+"txtperctAmt").value=parseFloat(roundNumber(Tax1,3))
                        document.getElementById(GV_Frm_Name+"txttot").value=rounditn(Total,2);
                        document.getElementById(GV_Frm_Name+"HidTotalAmount").value=rounditn(Total,2);
                        Total_Qty=parseFloat(Qty)+parseFloat(Total_Qty)
                    }
                    else
                    {
                        document.getElementById(GV_Frm_Name+"txttot").value= "0.00"
                    }
                }
                TotalNetamt=parseFloat(TotalNetamt)+parseFloat(document.getElementById(GV_Frm_Name+"txttot").value)         
            }  
            k=j+1
            if(j<10)
            {
                GV_Frm_Name1="ctl00_MyCPH1_GV_Details_ctl0"+k+"_";
            }
            else
            {
                GV_Frm_Name1="ctl00_MyCPH1_GV_Details_ctl"+k+"_"; 
            }
            document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value=rounditn(TotalNetamt,2)
            //document.getElementById(FRM_Name+"TxtGrandTot").value=rounditn(parseFloat(document.getElementById(FRM_Name+"TxtOctAmt").value)+parseFloat(document.getElementById(FRM_Name+"TxtCarAmt").value)+parseFloat(document.getElementById(FRM_Name+"TxtLabAmt").value)+parseFloat(document.getElementById(FRM_Name+"TxtLaodAmt").value)+parseFloat(document.getElementById(FRM_Name+"TxtUnLaodAmt").value)+parseFloat(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value))
            if(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value<parseFloat(document.getElementById(FRM_Name+"txtadv").value))
            {
                alert("Advance Amount can not be Greater than Total Amount");
                document.getElementById(FRM_Name+"txtadv").value="0.00"
                document.getElementById(FRM_Name+"txtadv").focus();
                return false;
            }
            document.getElementById(FRM_Name+"txtbalamt").value=rounditn(parseFloat(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value)-parseFloat(document.getElementById(FRM_Name+"txtadv").value),2);
            document.getElementById(FRM_Name+"Total_Amt").value=rounditn(parseFloat(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value)-parseFloat(document.getElementById(FRM_Name+"txtadv").value),2)
            document.getElementById(FRM_Name+"Total_Qty").value=Total_Qty
            document.getElementById(FRM_Name+"Hnd_BalAmt").value=document.getElementById(FRM_Name+"txtbalamt").value
            document.getElementById(FRM_Name+"txtadv").value=rounditn(document.getElementById(FRM_Name+"txtadv").value,2)
        }
function validPODate(id)
{
    var txtdate=document.getElementById(id);
    
    if(!isValidDate(txtdate.value,"Purchase Order"))
        return false;
	var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
            var dt =txtdate.value
            var dt_dd=dt.substring(0,2)
            var dt_mm=dt.substring(3,5)
            var dt_yy=dt.substring(6,10)
        
            var sdt =server_dt
            var sdt_dd=sdt.substring(0,2)
            var sdt_mm=sdt.substring(3,5)
            var sdt_yy=sdt.substring(6,10)

            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

            var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
		    var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
		    var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
		    FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
    				
		    var FinYear_todate_dd=FinYear_todate.substring(0,2)
		    var FinYear_todate_mm=FinYear_todate.substring(3,5)
		    var FinYear_todate_yy=FinYear_todate.substring(6,10)
		    FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
    		
            if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
            {
                alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Purchase Order Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
                txtdate.focus();
                return false;
            }
            if (dt>server_dt)
            {
                alert( "Purchase Order Date should not be greater than today's date !!!")
                txtdate.focus();
                return false;
            }
}

function OnSubmit()
    { 
        FRM_Name="ctl00_MyCPH1_" //User_CTR_Frm_Name
        var PO_Date=document.getElementById(FRM_Name+"txtpodt").value 
        var PO_Vendor=document.getElementById(FRM_Name+"Txt_Vendor").value  
        var txtManPONo=document.getElementById(FRM_Name+"txtManPONo").value
        var Assetcd
        var TyreModel
        var TyreSize
        var TyreMFG
        var TyreType
        var ddlMatCat;
        
       if(PO_Date == "")
        {
            alert("Please Enter Purchase Order Date");
            document.getElementById(FRM_Name+"txtpodt").focus()
            return false;
        }
        var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
        var dt =PO_Date
        var dt_dd=dt.substring(0,2)
        var dt_mm=dt.substring(3,5)
        var dt_yy=dt.substring(6,10)
    
        var sdt =server_dt
        var sdt_dd=sdt.substring(0,2)
        var sdt_mm=sdt.substring(3,5)
        var sdt_yy=sdt.substring(6,10)

        dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

        var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
		var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
		var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
		FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
		var FinYear_todate_dd=FinYear_todate.substring(0,2)
		var FinYear_todate_mm=FinYear_todate.substring(3,5)
		var FinYear_todate_yy=FinYear_todate.substring(6,10)
		FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
		
        if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
        {
            alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Purchase Order Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
            document.getElementById(FRM_Name+"txtpodt").focus();
            return false;
        }
        if (dt>server_dt)
        {
            alert( "Purchase Order Date should not be greater than today's date !!!")
            document.getElementById(FRM_Name+"txtpodt").focus();
            return false;
        }
        if(PO_Vendor == "")
        {
            alert("Please Select Purchase Order Vendor");
            document.getElementById(FRM_Name+"Txt_Vendor").focus()
            return false;
        }
        var Search_Char="~"
        if (document.getElementById(FRM_Name+'Txt_Vendor').value.indexOf(Search_Char)==-1)
		{
		    alert("Invalid Vendor Name~Code Format");
            document.getElementById(FRM_Name+'Txt_Vendor').focus();
            return false
        }
            
        FRM_Name="ctl00$MyCPH1$"
        Slect_One_YN="N"
        var grid=document.getElementById("ctl00_MyCPH1_GV_Details");
        var rows=grid.rows.length;  
        for(var i=2;i<=rows-1;i++)
        {                
            j=i
            if(j<10)
            {
                GV_Frm_Name="ctl00_MyCPH1_GV_Details_ctl0"+j+"_";
            }
            else
            {
                GV_Frm_Name="ctl00_MyCPH1_GV_Details_ctl"+j+"_"; 
            }
            ddlMatCat=document.getElementById("ctl00_MyCPH1_ddlMatCat");
            if(ddlMatCat.value=="01")
            {
                Assetcd=document.getElementById(GV_Frm_Name+"txtPackMaterial").value  
                             
            }
            else if (ddlMatCat.value=="02")
            {
                Assetcd=document.getElementById(GV_Frm_Name+"txtTyreModel").value                
                TyreSize=document.getElementById(GV_Frm_Name+"txtTyreSize").value 
                TyreMFG=document.getElementById(GV_Frm_Name+"txtMfg").value 
                TyreType=document.getElementById(GV_Frm_Name+"ddlTyreType").value
            }
            else if (ddlMatCat.value=="03")
            {
                Assetcd=document.getElementById(GV_Frm_Name+"txtSparePart").value
            }
            else if (ddlMatCat.value=="04")
            {
                Assetcd=document.getElementById(GV_Frm_Name+"txtGeneral").value
            }
            else if (ddlMatCat.value=="5" || ddlMatCat.value=="05")
            {
                Assetcd=document.getElementById(GV_Frm_Name+"txtStationary").value
            }
            else if (ddlMatCat.value=="6" || ddlMatCat.value=="06")
            {
                Assetcd=document.getElementById(GV_Frm_Name+"txtFixAsset").value
            }            
            else
            {
                Assetcd="";
            }
            if(Assetcd!="" && ddlMatCat.value!="02")
            {
                Slect_One_YN="Y"
            }
            else if(Assetcd != "" && TyreSize != "" && TyreMFG != "" && TyreType != "" && ddlMatCat.value == "02")
            {
                Slect_One_YN="Y"
            }
        }		     
        if(Slect_One_YN=="N")
        {
            alert( "PLz Enter Atleast One Record For PO. !!!")
            return false;
        }        
    	//document.getElementById(FRM_Name+"txtbalamt").disabled=false	
    	document.getElementById(FRM_Name+"txtadv").disabled=false	        
    }

function OnSubmitStep1()
{
    
    FRM_Name="ctl00_MyCPH1_"
    var PO_Vendor=document.getElementById(FRM_Name+"Txt_Vendor").value
    var PO_Date=document.getElementById(FRM_Name+"txtpodt").value
    ddlMatCat=document.getElementById("ctl00_MyCPH1_ddlMatCat");
    var PO_Date=document.getElementById(FRM_Name+"txtpodt").value 
    if(ddlMatCat.value=="")
    {
        alert("Please Material Category For PO Generation");
        document.getElementById("ctl00_MyCPH1_ddlMatCat").focus()
        return false;
    }
    if(PO_Vendor == "")
    {
        alert("Please Select Purchase Order Vendor");
        document.getElementById(FRM_Name+"Txt_Vendor").focus()
        return false;
    }
    var Search_Char="~"
    if (document.getElementById(FRM_Name+'Txt_Vendor').value.indexOf(Search_Char)==-1)
    {
        alert("Invalid Vendor Name~Code Format");
        document.getElementById(FRM_Name+'Txt_Vendor').focus();
        return false
    }
    if(PO_Date == "")
    {
        alert("Please Enter Purchase Order Date");
        document.getElementById(FRM_Name+"txtpodt").focus()
        return false;
    }
}
function Show_assetNM(Obj,Type)
{    
    if(Obj.value=="")
    {
        return false;
    }
    if(Type!="ManualPONo" && Type!="TyreModel")
    {
        var Search_Char="~"
	    if (Obj.value.indexOf(Search_Char)==-1)
	    {
	        alert("Invalid  Item  Name~Code Format");
	        Obj.focus();
	        return false
	    }
	}	
    var TxtAssetcode=Obj.id;
    var txtastnm=TxtAssetcode.replace( "txtassetcd", "txtastnm");
    var Assetcode_Arr=document.getElementById(TxtAssetcode).value.split("~");
    if(Type!="ManualPONo" && Type!="TyreModel")
    {
        Assetcode=Assetcode_Arr[1]    
    }
    else
    {
        Assetcode=document.getElementById(TxtAssetcode).value
    }
    if(Assetcode!="")
    {
        var findobj=false;
        findobj=GetXMLHttpObject();
        if(findobj)
        {
            var strpg="CheckExist.aspx?mode="+Type+"&Code=" + Assetcode + "&sid=" + Math.random();
            findobj.open("GET",strpg,true);
            findobj.onreadystatechange=function()
            {
                if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    
                    if(Type=="Vendor")
                    {
                        if(res[0]=="false")
                        {
                            alert("Vendor Code is not Valid... Please Enter Valid Vendor Code");
                            document.getElementById(TxtAssetcode).value="";
                            document.getElementById(TxtAssetcode).focus();
                            return false;
                        }        
                    }   
                    else if(Type=="ManualPONo")
                    {
                        if(res[0]=="false")
                        {
                            alert("Manual Po Number is Already Exist.. Please Enter Valid Manual PO Number.");
                            document.getElementById(TxtAssetcode).value="";
                            document.getElementById(TxtAssetcode).focus();
                            return false;
                        }        
                    }  
                    else
                    {
                        if(res[0]=="false")
                        {
                            alert("Item Code is not Valid... Please Enter Valid Item Code");
                            document.getElementById(TxtAssetcode).value="";
                            document.getElementById(TxtAssetcode).focus();
                            return false;
                        }
                    }                            
                }
            }
        findobj.send(null);
        }
    return false;    
    }
}
    </script>

    <div style="width: 10in">
        <table align="left" cellspacing="1" style="width: 90%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server"> General Information </asp:Label>
                </td>
            </tr>
            <tr style="background-color: #ffffff" id="trPOType" runat="server">
                <td style="width:2in">
                    <label class="blackfnt">
                        Select PO Type :
                    </label>
                </td>
                <td colspan="3" align="left" style="height: 21px">
                    <asp:DropDownList ID="ddlPOType" runat="server" >
                        <asp:ListItem Text="New" Selected="True" Value="New"></asp:ListItem>
                        <asp:ListItem Text="Old" Value="Old"></asp:ListItem>
                        <asp:ListItem Text="Remold" Value="Remold"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: #ffffff" id="trMatCat" runat="server">
                <td style="width:2in">
                    <label class="blackfnt">
                        Select Material Category :
                    </label>
                </td>
                <td colspan="3" align="left" style="height: 21px">
                    <asp:DropDownList ID="ddlMatCat" runat="server" OnSelectedIndexChanged="ddlMatCat_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: #ffffff" id="trPONo" runat="server">
                <td>
                    <label class="blackfnt">
                        Purchase Order ID :
                    </label>
                </td>
                <td>
                    <asp:Label ID="l1" Text="< System Generated... >" runat="server" ForeColor="red"
                        CssClass="blackfnt"></asp:Label>
                </td>
                <td>
                    <label class="blackfnt">
                        Purchase Order Date :</label>
                </td>
                <td>
                    <asp:TextBox ID="txtpodt" Width="70" runat="server" Enabled="false" CssClass="blackfnt" onblur="javascript:return validPODate(this.getAttribute('id'));"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtpodt,'anchor2','dd/MM/yyyy'); return false;"
                        name="anchor2" id="a2">
                        <img src="./../../../images/calendar.jpg" border="0" alt="" />
                    </a><font class="blackfnt">dd/mm/yyyy</font>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trVendor" runat="server">
                <td>
                    <label class="blackfnt">
                        Vendor Code :</label>
                    <asp:HiddenField ID="Total_Qty" runat="server" Value="0.00" />
                    <asp:HiddenField ID="Total_Amt" runat="server" />
                </td>
                <td class="blackfnt" colspan="0">
                    <asp:TextBox ID="Txt_Vendor" runat="server" Width="250" BorderStyle="Groove" CssClass="blackfnt"
                        onblur="javascript:Show_assetNM(this,'Vendor')"></asp:TextBox>
                    <div id="Abc" runat="server" class="boxbg" />
                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                        ServiceMethod="GetVendor" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="Txt_Vendor">
                    </ajaxToolkit:AutoCompleteExtender>
                </td>
                <td>
                    <label class="blackfnt">
                        Credit Days :
                    </label>
                </td>
                <td style="height: 26px">
                    <asp:TextBox ID="TxtCreditDays" Width="70" runat="server" Enabled="true" CssClass="blackfnt" ></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trManualPONo" runat="server">
                <td nowrap>
                    <label class="blackfnt">
                        Manual P.O. Number :</label>
                </td>
                <td>
                    <asp:TextBox ID="txtManPONo" Width="130" runat="server" MaxLength="6" onblur="javascript:return Show_assetNM(this,'ManualPONo');"></asp:TextBox>
                </td>
                <td nowrap>
                    <label class="blackfnt">
                        Kind Attn :</label>
                </td>
                <td>
                    <asp:TextBox ID="txtPerson" Width="130" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr class="bgbluegrey" id="trStep1" runat="server">
                <td colspan="4" align="right" style="height: 21px">
                    <asp:Button ID="btnStep1" runat="server" Text="Step - 1" Font-Bold="true" OnClientClick="javascript:return OnSubmitStep1();"
                        OnClick="btnStep1_Click" />
                </td>
            </tr>
            <br />
            <br />
            <tr bgcolor="white" id="trIndexRow" runat="server">
                <td colspan="4" align="center">
                    <br />
                    <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="350">
                        <tr style="background-color: White">
                            <td style="text-align: left" class="blackfnt">
                                &nbsp;Enter No. of Rows
                            </td>
                            <td style="text-align: left" class="blackfnt">
                                <asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                    Width="100px"></asp:TextBox>
                                &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Submit" OnClick="btnAdd_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trGrid" runat="server">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:GridView ID="GV_Details" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                        FooterStyle-CssClass="blackfnt" PagerStyle-HorizontalAlign="left" ShowFooter="True"
                        BackColor="white" CssClass="boxbg" OnRowDataBound="GV_D_OnRowDataBound" AutoGenerateColumns="False"
                        SelectedIndex="1" Width="95%">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tyre Model">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtTyreModel" runat="server" BorderStyle="Groove" Width="160px"
                                        onblur="javascript:return Show_assetNM(this,'TyreModel');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetTyreModel" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtTyreModel">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Tyre MFG">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtMfg" runat="server" BorderStyle="Groove" Width="160px" onblur="javascript:return Show_assetNM(this,'TyreMFG');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetTyreMFG" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtMfg">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Tyre Size">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtTyreSize" runat="server" BorderStyle="Groove" Width="160px" onblur="javascript:return Show_assetNM(this,'TyreSize');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetTyreSize" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtTyreSize">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tyre Category">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlTyreType" runat="server">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtdesc" Width="150" TextMode="MultiLine" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtqty" Width="50" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        runat="server" Text="0" onblur="javascript:return Check_Calc()" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unit Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="DDLType" runat="server">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtrate" Width="50" MaxLength="8" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lll" Text="Total :" Font-Bold="true" runat="server"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="% Of Discount ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscount" Width="50" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        Text="0.00" onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Discount Amount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscountAmt" Width="50" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        Text="0.00" onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="% Of Tax ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtperct" Width="50" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        Text="0.00" onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tax Amount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtperctAmt" Width="50" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        Text="0.00" onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Amount ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txttot" Width="70" Text="0.00" MaxLength="4" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField ID="HidTotalAmount" runat="server" />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="Txt_Total_netamt" Width="70" Text="0.00" runat="server" BorderStyle="Groove"
                                        Enabled="false" CssClass="blackfnt"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>

                        <FooterStyle CssClass="blackfnt"></FooterStyle>

                        <PagerStyle HorizontalAlign="Left"></PagerStyle>

                        <HeaderStyle CssClass="bgbluegrey"></HeaderStyle>
                    </asp:GridView>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trAdvAmt" runat="server">
                <td align="right" colspan="3">
                    <asp:Label ID="llll" Text="Advance Amount :" CssClass="blackfnt" Font-Bold="true"
                        runat="server"></asp:Label>
                </td>
                <td align="right" style="height: 21px">
                    <asp:TextBox ID="txtadv" Width="70" Text="0.00" onblur="javascript:return Check_Calc()"
                        onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" runat="server"
                        BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trBalAmt" runat="server">
                <td colspan="3" align="right">
                    <asp:Label ID="Label3" Text="Balance Amt. : " CssClass="blackfnt" Font-Bold="true"
                        runat="server"></asp:Label>
                </td>
                <td align="right" style="height: 21px">
                    <asp:HiddenField ID="Hnd_BalAmt" runat="server" Value="0.00" />
                    <asp:TextBox ID="txtbalamt" Width="70" Enabled="false" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                        runat="server" BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trProgessBar" runat="server">
                <td align="left" colspan="4">
                    <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                <tr>
                                    <td align="right">
                                        <img src="../../../images/loading.gif" alt="" />
                                    </td>
                                    <td>
                                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                opacity: .50; -moz-opacity: .50;" runat="server">
                                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                    left: 50%;" ID="Panel2" runat="server">
                                </asp:Panel>
                            </asp:Panel>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="background-color: #ffffff" id="trTerms" runat="server">
                <td nowrap>
                    <label class="blackfnt">
                        Term & Condition : Term & Condition :
                    </label>
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txtterm" TextMode="multiLine" Width="300" runat="server" onchange="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
            </tr>
            <%--<tr style="background-color: #FFFFFF" id="trPaymentCtrl" runat="server">
                <td colspan="4" align="center" style="height: 21px">
                    <table border="0" cellspacing="1" cellpadding="4" width="100%" align="left" class="boxbg">
                        <font class="blackfnt">Note : Please enter the payment details if Net Payable amount
                            &gt;0 . </font>
                        <br />
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Payment Details</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td align="center" colspan="4">
                                <asp:UpdatePanel ID="UpdatePanePayment" runat="server">
                                    <ContentTemplate>
                                        <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>--%>
            <tr style="background-color: #FFFFFF" id="trFinalSubmit" runat="server">
                <td colspan="4" align="center" style="height: 21px">
                    <table align="center" cellspacing="1" style="width: 100%" class="boxbg" border="0"
                        id="ON_Submit" runat="server">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Button ID="btn_submit" Text="Submit" OnClick="btn_submit_Click" OnClientClick="javascript:return OnSubmit()"
                                    runat="server" CssClass="blackfnt" />
                                <uc1:UserMessage ID="MsgBox" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="HidVendorCode" runat="server" />
        <asp:HiddenField ID="HidVendorName" runat="server" />
        <asp:HiddenField ID="HidManPONo" runat="server" />
        <asp:HiddenField ID="HidKind" runat="server" />
        <asp:HiddenField ID="HidPOdate" runat="server" />
        <asp:HiddenField ID="HidMatCat" runat="server" />
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
