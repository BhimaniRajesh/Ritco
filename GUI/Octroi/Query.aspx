<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="Octroi_Octroi_MR_Query" %>

<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
   
     var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    
	    
	    
    var doc = null; 
var formobj;
var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;


function calc()
    {
    
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var norows=grid.rows.length;
       
        var pref="";
//        var grandtotal=0.00;
//        var octamt=0.00;
//        var processchrg=0.00;
//        var stax=0.00;
//        var cess=0.00;
//        var hcess=0.00;
      //  var otchg=0.00;
       var grandtotal2=0.00;
         var pref="";
       
        var octamt=0.00;
        var processchrg=0.00;
        var stax=0.00;
        var cess=0.00;
        var hcess=0.00;
        var othr=0.00;
        var forsvc=0.00;
        
        for(var i=2;i<=norows;i++)
        {
          var grandtotal=0.00;
        
            if(i<10)
                pref="ctl00_MyCPH1_DataGrid1_ctl0" + i + "_";
            else
                pref="ctl00_MyCPH1_DataGrid1_ctl" + i + "_";
            
            var txtoctamt=document.getElementById(pref+"txtoctamt");
            var txtoctper=document.getElementById(pref+"txtoctper");
            var txtclearchrg=document.getElementById(pref+"txtclearchrg");
            var txtprochrg_per=document.getElementById(pref+"txtprochrg_per");
            var txtprochrg=document.getElementById(pref+"txtprochrg");
            var txtstax=document.getElementById(pref+"txtstax");
            var txtcess=document.getElementById(pref+"txtcess");
            var txthcess=document.getElementById(pref+"txthcess");
            var txtotchg=document.getElementById(pref+"txtotchg");
            var txttotalamt=document.getElementById(pref+"txttotalamt");
          //  var txttotalamt=document.getElementById(pref+"txttotalamt");



            octamt=parseFloat(txtoctamt.value);
            if(octamt==0)
            {
            }
            else
            {
          //  debugger
            grandtotal=grandtotal + octamt;  // Assigning Octroi Amount to Grand Total
            
            grandtotal=grandtotal + parseFloat(txtclearchrg.value); // Adding Cleasrance Charges to Grand Total
            
            processchrg=parseFloat(txtoctamt.value) * parseFloat(txtprochrg_per.value) / 100;
            
            grandtotal = grandtotal + processchrg; // Adding Processing Charges to Grand Total
            txtprochrg.value=processchrg
            
            //Calculating STAX where STAX = 12 % Processing Charges 
            forsvc = parseFloat(txtclearchrg.value)+processchrg+parseFloat(txtotchg.value)
            
            stax = (forsvc * 12) / 100;
            txtstax.value=stax;
            grandtotal = grandtotal + stax; // Adding STAX to Grand Total
            
            // Calculating CESS = 2 % of STAX
            cess=(stax*2)/100;
            txtcess.value=cess;
            grandtotal = grandtotal + cess;
            
            //Calculating HCESS = 1 % of STAX
            hcess=(stax*1)/100;
            txthcess.value=hcess;
            grandtotal = grandtotal + hcess;
            //alert(txtotchg.value);
             othr=parseFloat(txtotchg.value);
            grandtotal = grandtotal+othr;
            txttotalamt.value=grandtotal;
            grandtotal2+=grandtotal;
            
//             document.getElementById("ctl00_MyCPH1_txtbillamt").value =grandtotal2;
//              document.getElementById("ctl00_MyCPH1_h11").value = grandtotal2;
              }
            
        }
    
    
    }
	function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
	
	
	///***************
	
	
	
 function validmrdate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"MR Date"))
        txtdate.focus();
            return false;
}
function validRPDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Recipt Date"))
        txtdate.focus();
            return false;
}
function validBillDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Bill Date"))
        txtdate.focus();
            return false;
}
function validDueDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Due Date"))
        txtdate.focus();
            return false;
}


function validFloat(event,txtid)
{
var tb=document.getElementById(txtid);
var txt=tb.value;
if(event.keyCode==13)
return true;

if(event.keyCode==46)
if(txt.indexOf('.')!=-1)
event.keyCode=0;

if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
{event.keyCode=0;return false;}
}


function nonenone(event,txtid)
{
var tb=document.getElementById(txtid);
var txt=tb.value;
if(event.keyCode==13)
return true;

//if(event.keyCode==46)
//if(txt.indexOf('.')!=-1)
//event.keyCode=0;

//if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
//{
event.keyCode=0;return false;
//}
}

	
	
	///***************
	var p=true
	function doWork() {
	   
	    if (doc.readyState == 4) {
	    
	     
	    
	    
	     //alert(doc.responseText)
	          
	           
	           var res=doc.responseText.split("|");
	           
	           if (res[0]!="OK")
	           {
	          
	            alert(doc.responseText)
	            p=false
	            rt="";
	           // formobj.focus();
	            return false;
	                //formobj.value="";
	              
	           }
	           else
	           {
	         //  debugger
	                  var s= document.getElementById("ctl00_MyCPH1_hi").value;
	                  document.getElementById(s).value = res[1];
	           }
	    }
	}
       
        var f1,f2
        f1="1"
        f2="1"
        var dno=""


function dktcheck(d)
        {
    //    debugger
          var txdec=d.id;
         
          txdec=txdec.replace( "txtdockno", "txtdeclval");
          
            document.getElementById("ctl00_MyCPH1_hi").value=txdec;
            
        var dno=d.value;
          
                createXMLHTTPObject();
                 if (doc)
				 { 
             	                arg=new Date()
					            doc.onreadystatechange = doWork; 
					            if(dno=="")
					            {
					             alert("Enter Docket No.")
					           
//					             d.focus();
//					               return false;
					            }
					            else
					            {
					                doc.open("GET", "dochk.aspx?dno=" + dno, false);
					                doc.send(null);
					            }
				  }
               
             
        }
        
         Form_name="ctl00$MyCPH1$"
        function ValidateData()
   {
                
              if(document.getElementById("txtmrdt").value=="")
        {
        alert("Please Enter MR Date");
        }
                
        var mDerviedControlForDocketNo = "";
        var mDerviedControlForMRReceiptNo = "";
        var mDerviedControlForMRReceiptDate = "";
       
        var myflg="n";
        
        //Check for No. of Rows
        if(document.getElementById("ctl00_MyCPH1_roww"))
        {
            if(document.getElementById("ctl00_MyCPH1_roww").value != "")
            {
                for(var mLoopCounter = 1; mLoopCounter <= document.getElementById("ctl00_MyCPH1_roww").value; mLoopCounter++)
                {
                    
                    j=mLoopCounter+1
                    mDerviedControlForDocketNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtdockno";
                    mDerviedControlForMRReceiptNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcptno";
                    mDerviedControlForMRReceiptDate = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcptdate"
                     mDerviedControlForMRtxtprochrg_per = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtprochrg_per"
                      mDerviedControlForMRtxtprochrg = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtprochrg"
                      // mDerviedControlForMRtxttotalamt = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txttotalamt"
                        mDerviedControlForMRtxtoctper = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txttxtoctper"
                        //alert("hi...")
                        //alert(mDerviedControlForMRReceiptDate)
                       // alert(mDerviedControlForMRtxtprochrg_per)
                         if(mLoopCounter < 10)
                        {
                                               
                            frm3=Form_name+"DataGrid1$ctl"+"0"+j+"$"
                        }
                        else
                        {
                            frm3=Form_name+"DataGrid1$ctl"+j+"$"
                           
                        }
                    
                        
                        document.getElementById(frm3+"txtprochrg_per").disabled=false
                        document.getElementById(frm3+"txtprochrg").disabled=false
                        document.getElementById(frm3+"txtoctper").disabled=false
                        document.getElementById(frm3+"txttotalamt").disabled=false
                        
                    if(document.getElementById(mDerviedControlForDocketNo) && document.getElementById(mDerviedControlForMRReceiptNo) && document.getElementById(mDerviedControlForMRReceiptDate))
                    {
                        if(document.getElementById(mDerviedControlForDocketNo).value != "")
                        {      
                        myflg="y";                     
                            if(document.getElementById(mDerviedControlForMRReceiptNo).value == "")
                            {
                                alert("Enter Receipt No. for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptNo).focus();
                                return false;
                            }
                            if(document.getElementById(mDerviedControlForMRReceiptDate).value == "")
                            {
                                alert("Enter Receipt Date for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptDate).focus();
                                return false;
                            }
                        }
                    }                    
                }
            }
            else
            {
                return false;
            }
        }
        
        if(myflg=="n")
        {
            alert("Enter Atleast One Docket No.")
            return false;
        }
        return true;
        
        
   }
   
        
        
      /*  /////////   old **************************
	
   function ValidateData()
   {
        var mDerviedControlForDocketNo = "";
        var mDerviedControlForMRReceiptNo = "";
        var mDerviedControlForMRReceiptDate = "";
        
        //Check for No. of Rows
        if(document.getElementById("ctl00_MyCPH1_roww"))
        {
            if(document.getElementById("ctl00_MyCPH1_roww").value != "")
            {
                for(var mLoopCounter = 1; mLoopCounter <= document.getElementById("ctl00_MyCPH1_roww").value; mLoopCounter++)
                {
                    mDerviedControlForDocketNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtdockno";
                    mDerviedControlForMRReceiptNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcptno";
                    mDerviedControlForMRReceiptDate = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcptdate"
                    
                    if(document.getElementById(mDerviedControlForDocketNo) && document.getElementById(mDerviedControlForMRReceiptNo) && document.getElementById(mDerviedControlForMRReceiptDate))
                    {
                        if(document.getElementById(mDerviedControlForDocketNo).value != "")
                        {                           
                            if(document.getElementById(mDerviedControlForMRReceiptNo).value == "")
                            {
                                alert("Enter Receipt No. for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptNo).focus();
                                return false;
                            }
                            if(document.getElementById(mDerviedControlForMRReceiptDate).value == "")
                            {
                                alert("Enter Receipt Date for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptDate).focus();
                                return false;
                            }
                        }
                    }                    
                }
            }
            else
            {
                return false;
            }
        }
        
        return true;
   }
   
   function AddRowNo(txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8)
  {
//	 var val1 = document.getElementById(txt1).value;
//     var val2 = document.getElementById(txt2).value;
//     var val3 = document.getElementById(txt3).value;
//     var val4 = document.getElementById(txt4).value;
//     var val5 = document.getElementById(txt5).value;
//     var val6 = document.getElementById(txt6).value;
//     var val7 = document.getElementById(txt7).value;
//     var val8 = document.getElementById(txt8).value;
//     
//  if(val1 == "" && val2 == "" && val3 == "" && val4 == "" && val5 == "" && val6 == "" && val7 == "" && val8 == "") 
//  return false   
//  
// if(isNaN(val1))
// {
// alert("Please Enter Only Number")
// document.getElementById(txt1).focus();
// return false;
// }
// 
//  if(isNaN(val2))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt2).focus();
//    return false;
//  }
// if(isNaN(val3))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt3).focus();
//    return false;
//  }
// if(isNaN(val4))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt4).focus();
//    return false;
//  }
// if(isNaN(val5))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt5).focus();
//    return false;
//  }
//  if(isNaN(val6))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt6).focus();
//    return false;
//  }
//  if(isNaN(val7))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt7).focus();
//    return false;
//  }
//  if(isNaN(val8))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt8).focus();
//    return false;
//  }
//  
//  if(Number(val1) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt1).focus();
//    return false;
//  }
//  
//  if(Number(val2) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt2).focus();
//    return false;
//  }
//  if(Number(val3) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt3).focus();
//    return false;
//  }
//  if(Number(val4) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt4).focus();
//    return false;
//  }
//  if(Number(val5) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt5).focus();
//    return false;
//  }
//  if(Number(val6) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt6).focus();
//    return false;
//  }
//  if(Number(val7) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt7).focus();
//    return false;
//  }


//    var Oct_Per=Math.round((parseFloat(val1)*80)/parseFloat(val7))
//    document.getElementById(txt2).value = Oct_Per
//     
//    //debugger
//     
//    var OctPer=Math.round(((parseFloat(val1)*parseFloat(val4))/80))
//    if(isNaN(OctPer))
//    {
//    document.getElementById(txt5).value=0
//    }
//    else
//    {
//    document.getElementById(txt5).value=OctPer
//    }
//    if(isNaN(OctPer))
//    {
//    document.getElementById(txt6).value=0
//    }
//    var TotalChrg=parseFloat(val1)+OctPer+parseFloat(val6)+parseFloat(val3)
//    if(isNaN(TotalChrg))
//    {
//        document.getElementById(txt8).value=0
//    }
//    else
//    {
//        document.getElementById(txt8).value=TotalChrg
//    }  
 }
 
 
 function tupper(obj)
{
//alert("hi...")
obj.value=obj.value.toUpperCase()
//txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");
}
===================================================================================*/
    </script>

    <br />
    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Manual Octroi MR</b></font></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <div style="width: 9.5in">
        <br />
        <asp:Panel ID="plnerr" Visible="false" runat="server">
            <table width="90%">
                <tr>
                    <td align="center">
                        <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="Label3" Text="Please Try Again....." runat="server"></asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel ID="pnl1" runat="server">
            <br />
            <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                <tr bgcolor="white">
                    <td align="left" style="width: 132px; height: 40px">
                        <font class="bluefnt">Enter the No. of Rows</font></td>
                    <td align="center">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <center>
                                    <asp:TextBox ID="roww" runat="server" BorderStyle="Groove" AutoPostBack="true" OnTextChanged="roww_TextChanged"
                                        Width="40px">1</asp:TextBox>&nbsp;</center>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td>
                        <font class="bluefnt">MRs Date</font></td>
                    <td>
                        <asp:TextBox ID="txtmrdt" runat="server" onblur="javascript:return validDueDate(this.getAttribute('id'));"
                            Width="99px"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtmrdt,'anchor3','dd/MM/yyyy'); return false;"
                            name="anchor3" id="a3">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a><font class="blackfnt">dd/mm/yyyy</font>
                        <asp:HiddenField ID="hi" runat="server" />
                    </td>
                </tr>
            </table>
            <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                <ContentTemplate>
                    <center>
                        &nbsp;</center>
                    <center>
                        <table align="center" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                            <tr bgcolor="white">
                                <td colspan="3" align="center">
                                    <font class="bluefnt"><strong>CUSTOMER MR Detail<br />
                                    </strong></font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td colspan="3">
                                    <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" CellPadding="1"
                                        CssClass="boxbg" BorderWidth="0" CellSpacing="1" Width="90%">
                                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" />
                                        <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center"
                                            Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White"
                                            Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                        <HeaderStyle CssClass="bgbluegrey" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Sr. No.">
                                                <ItemTemplate>
                                                    <center>
                                                        <font class="blackfnt">
                                                            <%# Container.ItemIndex+1 %>
                                                        </font>
                                                    </center>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt">
                                                <HeaderTemplate>
                                                    <center>
                                                        <asp:Label ID="l1" runat="server" Text='<%#Session["DocketCalledAs"]+" No."%>'></asp:Label>
                                                    </center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdockno" runat="server" onblur="return dktcheck(this)" BorderStyle="Groove"
                                                       Width="80"  Text='<%# DataBinder.Eval(Container.DataItem, "dockno")%>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Declared Value">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdeclval" runat="server" BorderStyle="Groove"  Width="80" Columns="8"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Octroi Amt.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtoctamt" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                       Width="60"   onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Octroi(%)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtoctper" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Enabled="false"
                                                        Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Clearance Charges">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtclearchrg" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Processing Charges(%)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtprochrg_per" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Processing Charges">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtprochrg" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"  ></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Other Charges">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtotchg" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="S.Tax">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtstax" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="40"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Cess">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtcess" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));" onblur="javascript:return calc()" BorderStyle="Groove"
                                                           Width="40"  Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Higher Edu. Cess">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txthcess" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="40"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Total">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txttotalamt" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0" ></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Reciept No.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtrcptno"    Width="60"  runat="server" BorderStyle="Groove" Columns="10"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Receipt Date ">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtrcptdate" runat="server" BorderStyle="Groove" onblur="javascript:return validRPDate(this.getAttribute('id'));"
                                                         Width="60"    Columns="12"></asp:TextBox>
                                                    <%-- <asp:RegularExpressionValidator ID="rg1" runat="server" ControlToValidate="txtrcptdate"
                                                    ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>--%>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid></td>
                            </tr>
                        </table>
                    </center>
                    <center>
                        &nbsp;</center>
                </ContentTemplate>
                <%--<Triggers>
            <asp:AsyncPostBackTrigger ControlID="roww_TextChanged" EventName="Click" />
        </Triggers>--%>
            </asp:UpdatePanel>
            <br />
            <table align="left" border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 692px;
                height: 76px">
                <%-- <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 7px; height: 36px;">
            </td>
            <td align="left" class="blackfnt"  >
                <strong>Your Next Step</strong></td>
        </tr>--%>
                <tr>
                    <td bgcolor="white">
                        &nbsp;<img src="../../images/clear.gif" width="4" height="4" /></td>
                    <td bgcolor="white">
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return ValidateData()"
                            Font-Underline="true" OnClick="fun1">Prepare SEPARATE MR for one for each selected docket; consignee as MR party</asp:LinkButton></td>
                </tr>
                <tr>
                    <td bgcolor="white">
                        &nbsp;<img src="../../images/clear.gif" width="4" height="4" /></td>
                    <td align="left" bgcolor="white">
                        <asp:LinkButton ID="LinkButton2" Font-Underline="true" runat="server" OnClick="fun2">Prepare SEPARATE MR for one for each selected docket; consignor as MR party</asp:LinkButton></td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
