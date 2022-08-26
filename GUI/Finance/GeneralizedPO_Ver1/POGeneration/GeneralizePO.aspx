<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GeneralizePO.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POGeneration_GeneralizePO" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl_FA.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="uc1" %>

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
        var FinYear="<%=Session["FinYear"]%>"
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
                Rate=document.getElementById(GV_Frm_Name+"txtrate").value
                Total=document.getElementById(GV_Frm_Name+"txttot").value
                Discount=document.getElementById(GV_Frm_Name+"txtDiscount").value
                
                
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
                        var Tax1="0",Discount1="0",Total_Discount="0";
                        Total=parseFloat(Qty)*parseFloat(Rate)
                        
                        Discount1=(parseFloat(roundNumber(Total,2)) * Discount / 100)
                        Total_Discount=parseFloat(roundNumber(Total,2)) - parseFloat(roundNumber(Discount1,2))
                        
                        Tax1=((parseFloat(roundNumber(Total_Discount,2))*parseFloat(Tax))/100)
                        
                        Total = Total - Discount1 + Tax1
//                        TaxAmt=((parseFloat(Total)*parseFloat(Tax))/100)
//                        Total=(parseFloat(Total))+(parseFloat((parseFloat(TaxAmt)/100)*1)/100)
//                        Total=(parseFloat(Total))+(parseFloat((parseFloat(TaxAmt)/100)*2)/100)
                        //Total=(parseFloat(Total))-(parseFloat(Total)*parseFloat(Discount)/100)
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
            if(parseFloat(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value)<parseFloat(document.getElementById(FRM_Name+"txtadv").value))
            {
                alert("Advance Amount can not be Greater than Total Amount");
                document.getElementById(FRM_Name+"txtadv").value="0.00"
                document.getElementById(FRM_Name+"txtadv").focus();
                return false;
            }
            document.getElementById(FRM_Name+"txtbalamt").value=rounditn(parseFloat(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value)-parseFloat(document.getElementById(FRM_Name+"txtadv").value),2)
            document.getElementById(FRM_Name+"Total_Amt").value=rounditn(parseFloat(document.getElementById(GV_Frm_Name1+"Txt_Total_netamt").value)-parseFloat(document.getElementById(FRM_Name+"txtadv").value),2)
            document.getElementById(User_CTR_Frm_Name+"txtNetPay").value=rounditn(parseFloat(document.getElementById(FRM_Name+"txtadv").value),2)
            document.getElementById(User_CTR_Frm_Name+"txtAmtApplA").value=rounditn(parseFloat(document.getElementById(FRM_Name+"txtadv").value),2)
            document.getElementById(FRM_Name+"Total_Qty").value=Total_Qty
            document.getElementById(FRM_Name+"Hnd_BalAmt").value=document.getElementById(FRM_Name+"txtbalamt").value 
            cahs_N_bank();
            document.getElementById(FRM_Name+"txtadv").value=rounditn(document.getElementById(FRM_Name+"txtadv").value,2)
        }  
function cahs_N_bank()
{
    if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Cash")
    {
        document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value=rounditn(document.getElementById(frm_name+"txtadv").value,2)
        document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value="0.00"
    }
    else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Bank")
    {
        document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value=rounditn(document.getElementById(frm_name+"txtadv").value,2)
        document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value="0.00"
    }
    else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both")
    {
        document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value="0.00"
        document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value="0.00"
    }
}
function bal()
{
    var tot1= document.getElementById("ctl00$MyCPH1$GV_Details$ctl12$txttottot")
    var adv= document.getElementById("ctl00$MyCPH1$txtadv")
    if(Number(tot1.value)<Number(adv.value))
    {
        alert("Advance Amount can not be Greater than Total Amount");
        adv.focus();
        return false;
    }
    else
    {
        var balamt=Number(tot1.value)-Number(adv.value)
        if(document.getElementById("ctl00$MyCPH1$cboModeOfTransaction").value=="Cash")
        {
            document.getElementById("ctl00$MyCPH1$txtCashAmount").value=adv.value;
        }
        else
        {
            document.getElementById("ctl00$MyCPH1$txtCashAmount").value=adv.value;
            document.getElementById("ctl00$MyCPH1$txtPaymentAmt").value=adv.value;
        }
        document.getElementById("ctl00$MyCPH1$txtbalamt").value=balamt;
    }
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



function validQuotationDate(id)
{

//    var txtdate=document.getElementById(id);
//    
//        if(!isValidDate(txtdate.value,"Quotation"))
//            document.getElementById(id).focus()
//            return false;
}


function validRequisitionDate(id)
{

//    var txtdate=document.getElementById(id);
//    
//        if(!isValidDate(txtdate.value,"Requisition"))
//        document.getElementById(id).focus()
//            return false;
}


function validChequeDate(id)
{
    var txtdate=document.getElementById(id);    
        if(!isValidDate(txtdate.value,"Cheque"))
        document.getElementById(id).focus()
            return false;
}

    function OnSubmit()
    { 
        FRM_Name="ctl00_MyCPH1_" //User_CTR_Frm_Name
        var PO_Date=document.getElementById(FRM_Name+"txtpodt").value 
        var PO_Vendor=document.getElementById(FRM_Name+"Txt_Vendor").value  
        var txtManPONo=document.getElementById(FRM_Name+"txtManPONo").value
        var Paybas =document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_ddlPayMode").value
        var ChqNo=document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtChqNo").value
        var ChqDate=document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtChqDate").value
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
        if(Paybas == "Bank" && ChqNo == "")
        {
            alert("Please Enter the Cheque Number");
            document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtChqNo").focus()
            return false;
        }
        if(Paybas == "Bank" && ChqDate == "")
        {
            alert("Please Enter the Cheque Date");
            document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtChqDate").focus()
            return false;
        }
//        if(txtManPONo == "")
//        {
//            alert("PLz Enter Manual PO Number");
//            document.getElementById(FRM_Name+"txtManPONo").focus()
//            return false;
//        }      
        FRM_Name="ctl00$MyCPH1$"
        Slect_One_YN="N"
        var grid=document.getElementById("ctl00_MyCPH1_GV_Details");
        var rows=grid.rows.length;  
        for(var i=2;i<rows-1;i++)
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
    	document.getElementById(User_CTR_Frm_Name+"txtChqDate").disabled=false	
        document.getElementById(User_CTR_Frm_Name+"txtChqNo").disabled=false	
        document.getElementById(User_CTR_Frm_Name+"txtChqAmt").disabled=false	
        document.getElementById(User_CTR_Frm_Name+"txtNetPay").disabled=false
        document.getElementById(User_CTR_Frm_Name+"txtCashAmt").disabled=false	
    	document.getElementById(FRM_Name+"txtbalamt").disabled=false	
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
    if(Type!="ManualPONo")
    //if(Type!="ManualPONo" && Type!="TyreModel")
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
    //if(Type!="ManualPONo" && Type!="TyreModel")
    if(Type!="ManualPONo")
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
        <table align="center" cellspacing="1" style="width: 80%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       General Information
                    </asp:Label>
                </td>
            </tr>
            <tr style="background-color: #ffffff" id="trMatCat" runat="server">
                <td>
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
                    <asp:TextBox ID="txtpodt" Width="70" runat="server" CssClass="blackfnt" onblur="javascript:return validPODate(this.getAttribute('id'));"></asp:TextBox>
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
                <td class="blackfnt" colspan="3">
                    <asp:TextBox ID="Txt_Vendor" runat="server" Width="500" BorderStyle="Groove" CssClass="blackfnt"
                        onblur="javascript:Show_assetNM(this,'Vendor')"></asp:TextBox>
                    <div id="Abc" runat="server" class="boxbg" />
                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                        ServiceMethod="GetVendor" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="Txt_Vendor">
                    </ajaxToolkit:AutoCompleteExtender>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF; display: none" id="trQutation" runat="server">
                <td style="height: 26px" nowrap>
                    <label class="blackfnt">
                        Quotation No.:
                    </label>
                </td>
                <td style="height: 26px">
                    <asp:TextBox ID="txtqno" Width="100" runat="server" onchange="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
                <td style="height: 26px" nowrap>
                    <label class="blackfnt">
                        Quotation Date:
                    </label>
                </td>
                <td style="height: 26px">
                    <asp:TextBox ID="txtqdt" Width="70" runat="server" CssClass="blackfnt" onblur="javascript:return validQuotationDate(this.getAttribute('id'))"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtqdt,'anchor3','dd/MM/yyyy'); return false;"
                        name="anchor3" id="a3">
                        <img src="./../../../images/calendar.jpg" border="0"></img>
                    </a><font class="blackfnt">dd/mm/yyyy</font>
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
                        Kind Attn. :</label>
                </td>
                <td>
                    <asp:TextBox ID="txtkind" Width="130" runat="server"></asp:TextBox>
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
                                &nbsp;<asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" CssClass="blackfnt"
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
                        SelectedIndex="1">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" Width="50" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="false" Font-Bold="true" />
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lblItemHeader" runat="server" Width="150px"></asp:Label></center>
                                    <center>
                                        <asp:Label ID="lblItemHeader1" runat="server" Width="150px"></asp:Label></center>
                                    <center>
                                        <asp:Label ID="lblItemHeader2" runat="server" Width="150px"></asp:Label></center>
                                    <center>
                                        <asp:Label ID="lblItemHeader3" runat="server" Width="150px"></asp:Label></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPackMaterial" runat="server" BorderStyle="Groove" Width="200px"
                                        onblur="javascript:return Show_assetNM(this,'SKU');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                        ServiceMethod="Get_GeneralAsset" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtPackMaterial">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:TextBox ID="txtTyreModel" runat="server" BorderStyle="Groove" Width="150px"
                                        onblur="javascript:return Show_assetNM(this,'TyreModel');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetTyreModel" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtTyreModel">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:TextBox ID="txtMfg" runat="server" BorderStyle="Groove" Width="150px" onblur="javascript:return Show_assetNM(this,'TyreMFG');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetTyreMFG" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtMfg">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:TextBox ID="txtTyreSize" runat="server" BorderStyle="Groove" Width="150px" onblur="javascript:return Show_assetNM(this,'TyreSize');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetTyreSize" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtTyreSize">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:DropDownList ID="ddlTyreType" runat="server">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtSparePart" runat="server" BorderStyle="Groove" Width="150px"
                                        onblur="javascript:return Show_assetNM(this,'Spare');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="GetSpareParts" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtSparePart">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:TextBox ID="txtGeneral" runat="server" BorderStyle="Groove" Width="150px" onblur="javascript:return Show_assetNM(this,'SKU');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="Get_GeneralAsset" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtGeneral">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:TextBox ID="txtStationary" runat="server" BorderStyle="Groove" Width="200px" onblur="javascript:return Show_assetNM(this,'SKU');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="Get_StationaryAsset" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtStationary">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <asp:TextBox ID="txtFixAsset" runat="server" BorderStyle="Groove" Width="200px" onblur="javascript:return Show_assetNM(this,'FixAsset');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender7" runat="server" Enabled="True"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        MinimumPrefixLength="1" ServiceMethod="Get_FixAsset" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtFixAsset">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <br />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtdesc" Width="150" TextMode="MultiLine" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" Width="80" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtqty" Width="70" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        runat="server" Text="0" onblur="javascript:return Check_Calc()" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtrate" Width="70" MaxLength="8" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lll" Text="Total :" Font-Bold="true" runat="server"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="% Of Discount ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscount" Width="70" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        Text="0.00" onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="% Of Tax ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtperct" Width="70" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        Text="0.00" onblur="javascript:return Check_Calc()" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Amount ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txttot" Text="0.00" MaxLength="4" runat="server" BorderStyle="Groove"
                                        CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField ID="HidTotalAmount" runat="server" />                                        
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="Txt_Total_netamt" Text="0.00" runat="server" BorderStyle="Groove"
                                        Enabled="false" CssClass="blackfnt"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
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
                        onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" 
                        runat="server" BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trBalAmt" runat="server">
                <td colspan="3" style="width: 90%" align="right">
                    <asp:Label ID="Label3" Text="Balance Amt. : " CssClass="blackfnt" Font-Bold="true"
                        runat="server"></asp:Label>
                </td>
                <td align="right" style="height: 21px">
                    <asp:HiddenField ID="Hnd_BalAmt" runat="server" Value="0.00" />
                    <asp:TextBox ID="txtbalamt" Width="70" Enabled="false" Text="0.00" 
                        onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" runat="server"
                        BorderStyle="Groove"></asp:TextBox>
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
            <tr style="background-color: #ffffff; display: none" id="trRequiDet" runat="server">
                <td style="height: 24px" nowrap>
                    <label class="blackfnt">
                        Requisition No. :
                    </label>
                </td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtreqno" Width="100" runat="server" onchange="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
                <td style="height: 24px" nowrap>
                    <label class="blackfnt">
                        Requisition Date :</label>
                </td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtreqdt" CssClass="blackfnt" Width="70" runat="server"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtreqdt,'anchor5','dd/MM/yyyy'); return false;"
                        name="anchor5" id="a5">
                        <img src="./../../../images/calendar.jpg" border="0"></img>
                    </a>
                </td>
            </tr>
            <tr style="background-color: #ffffff" id="trTerms" runat="server">
                <td nowrap>
                    <label class="blackfnt">
                        Term & Condition :
                    </label>
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txtterm" TextMode="multiLine" Width="300" runat="server" onchange="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trPaymentCtrl" runat="server">
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
            </tr>
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
