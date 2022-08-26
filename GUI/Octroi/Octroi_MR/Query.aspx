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

function Svctax_enable_disable()
    {
    
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var norows=grid.rows.length;
       
        var pref="";

        
        for(var i=2;i<=norows;i++)
        {
          var grandtotal=0.00;
        
            if(i<10)
                pref="ctl00_MyCPH1_DataGrid1_ctl0" + i + "_";
            else
                pref="ctl00_MyCPH1_DataGrid1_ctl" + i + "_";
            
           if(document.getElementById("ctl00_MyCPH1_svctax_yn").checked==true)
           {
            document.getElementById(pref+"txtstax").disabled=true;
            document.getElementById(pref+"txtcess").disabled=true;
            document.getElementById(pref+"txthcess").disabled=true;
           }
           else
           {
           document.getElementById(pref+"txtstax").disabled=false;
            document.getElementById(pref+"txtcess").disabled=false;
            document.getElementById(pref+"txthcess").disabled=false;
           }
           
       }
       calc()
 }


function calc()
    {
    
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var norows=grid.rows.length;
       
        var pref="";

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
              var txtdeclval=document.getElementById(pref+"txtdeclval");
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
            var perct = parseFloat(txtoctamt.value) * 100 / parseFloat(txtdeclval.value);
            txtoctper.value = rounditn(perct,2);
          
            grandtotal=grandtotal + octamt;  // Assigning Octroi Amount to Grand Total
            
            grandtotal=grandtotal + parseFloat(txtclearchrg.value); // Adding Cleasrance Charges to Grand Total
            
            processchrg=parseFloat(txtoctamt.value) * parseFloat(txtprochrg_per.value) / 100;
            
            grandtotal = grandtotal + processchrg; // Adding Processing Charges to Grand Total
            txtprochrg.value=rounditn(processchrg,2)
            
            //Calculating STAX where STAX = 12 % Processing Charges 
            forsvc = parseFloat(txtclearchrg.value)+processchrg+parseFloat(txtotchg.value)
            
            if(document.getElementById("ctl00_MyCPH1_svctax_yn").checked==false)
            {
                stax = (forsvc * 12) / 100;
                txtstax.value=rounditn(stax,2);
                grandtotal = grandtotal + stax; // Adding STAX to Grand Total
                
                // Calculating CESS = 2 % of STAX
                cess=(stax*2)/100;
                txtcess.value=rounditn(cess,2);
                grandtotal = grandtotal + cess;
                
                //Calculating HCESS = 1 % of STAX
                hcess=(stax*1)/100;
                txthcess.value=rounditn(hcess,2);
                grandtotal = grandtotal + hcess;
             }
             else
             {
             txtstax.value="0.00"
             txtcess.value="0.00"
             txthcess.value="0.00"
             }
            //alert(txtotchg.value);
            othr=parseFloat(txtotchg.value);
            grandtotal = grandtotal+othr;
            
           
            txttotalamt.value=Math.round(rounditn(grandtotal,2));
            grandtotal2+=grandtotal;
//             document.getElementById("ctl00_MyCPH1_txtbillamt").value =grandtotal2;
//              document.getElementById("ctl00_MyCPH1_h11").value = grandtotal2;
              }
            
        }
    
    
    }
    function rounditn(Num,decplaces)
{
Places=decplaces
if (Places > 0)
{

if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1))
{

if (Num.toString().lastIndexOf('.') < 0)
{
return Num.toString() +'.00';
}
var Rounder = Math.pow(10, Places);
return Math.round(Num * Rounder) / Rounder;
}
else
{
//alert("Hi")
if (Num.toString().lastIndexOf('.') < 0)
{
return Num.toString() +'.00';
}
else
{
if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
return Num.toString() +'0';
else
return Num.toString();

}
}
}
else return Math.round(Num);

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
	         //alert(res)
	                    var s1= document.getElementById("ctl00_MyCPH1_declval").value;
	                    var s2= document.getElementById("ctl00_MyCPH1_octamt").value=txdec_octamt;
                        var s3= document.getElementById("ctl00_MyCPH1_recptno").value=txdec_recptno;
                        var s4= document.getElementById("ctl00_MyCPH1_recptdt").value=txdec_recptdt;
                        
	                    document.getElementById(s1).value = res[1];
	                    
	                    document.getElementById(s2).value = res[2];
	                    if(res[2]>0)
	                    {
	                    document.getElementById(s2).disabled=true
	                    }
	                    document.getElementById(s3).value = res[3];
	                    if(res[3]!="")
	                    {
	                    document.getElementById(s3).disabled=true
	                    }
	                    document.getElementById(s4).value = res[4];
	                    if(res[4]!="")
	                    {
	                    document.getElementById(s4).disabled=true
	                    }
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
         
            txdec_declval=txdec.replace( "txtdockno", "txtdeclval");
            txdec_octamt=txdec.replace( "txtdockno", "txtoctamt");
            txdec_recptno=txdec.replace( "txtdockno", "txtrcptno");
            txdec_recptdt=txdec.replace( "txtdockno", "txtrcptdate");
            
            document.getElementById("ctl00_MyCPH1_declval").value=txdec_declval;
            document.getElementById("ctl00_MyCPH1_octamt").value=txdec_octamt;
            document.getElementById("ctl00_MyCPH1_recptno").value=txdec_recptno;
            document.getElementById("ctl00_MyCPH1_recptdt").value=txdec_recptdt;
            
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
                
             
              if(document.getElementById(Form_name+"txtmrdt").value=="")
                {
                    alert("Please Enter MR Date");
                    document.getElementById(Form_name+"txtmrdt").focus()
                    return false;
                }
                
        var mDerviedControlForDocketNo = "";
        var mDerviedControlForMRReceiptNo = "";
        var mDerviedControlForMRReceiptDate = "";
       
        var myflg="n";
        
       
            frmname="ctl00$MyCPH1$"
            //alert("hi..")
            NoofRows=document.getElementById(frmname+"roww").value
            if(document.getElementById("ctl00$MyCPH1$DataGrid1$ctl02$txtdockno").value=="")
            {
                alert("PLz Enter atleast One DOcket")
                document.getElementById("ctl00$MyCPH1$DataGrid1$ctl02$txtdockno").focus()
                return false;
            }
             
            for (var i=0;i<NoofRows;i++)
            {
                j=i+2
                if(j<10)
                {
                    frmname_grid="ctl00$MyCPH1$DataGrid1$ctl0"+j+"$"
                }
                else
                {
                    frmname_grid="ctl00$MyCPH1$DataGrid1$ctl"+j+"$"
                }
                Docketno=document.getElementById(frmname_grid+"txtdockno").value
                for (var l=0;l<NoofRows;l++)
                {
                        m=l+2
                        if(m<10)
                        {
                            frmname_grid="ctl00$MyCPH1$DataGrid1$ctl0"+m+"$"
                        }
                        else
                        {
                            frmname_grid="ctl00$MyCPH1$DataGrid1$ctl"+m+"$"
                        }
                        Docketno1=document.getElementById(frmname_grid+"txtdockno").value
                        if (Docketno1!="")
				        {
					        if ((j!=m)&&(Docketno==Docketno1))
					        {
						        alert("Duplicate Docket Number,Please verify Docket Number!!!");
						        document.getElementById(frmname_grid+"txtdockno").focus();
						        return false;
					        }			
				        }
                }
                totalamount=parseFloat(document.getElementById(frmname_grid+"txttotalamt").value)
                if(totalamount<=0)
                {
                    alert("PLz Enter Total Amount Greater then Zero")
                    document.getElementById(frmname_grid+"txttotalamt").focus();
                    return false;
                }
                        document.getElementById(frmname_grid+"txtprochrg_per").disabled=false
                        document.getElementById(frmname_grid+"txtprochrg").disabled=false
                        document.getElementById(frmname_grid+"txtoctper").disabled=false
                        document.getElementById(frmname_grid+"txttotalamt").disabled=false
                        
                        document.getElementById(frmname_grid+"txtdeclval").disabled=false
                        document.getElementById(frmname_grid+"txtoctamt").disabled=false
                        document.getElementById(frmname_grid+"txtrcptdate").disabled=false
                        document.getElementById(frmname_grid+"txtrcptno").disabled=false
                        
                        document.getElementById(frmname_grid+"txtstax").disabled=false
                        document.getElementById(frmname_grid+"txtcess").disabled=false
                        document.getElementById(frmname_grid+"txthcess").disabled=false
                
            }
            //alert("done")
           // return false;
        return true;
        
        
   }
   
        
        
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
                         <asp:HiddenField ID="declval" runat="server" />
                        <asp:HiddenField ID="octamt" runat="server" />
                        <asp:HiddenField ID="recptno" runat="server" />
                        <asp:HiddenField ID="recptdt" runat="server" />
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
                                <td colspan="3" align="Left">
                                    <font class="redfnt"><strong><asp:CheckBox runat="server" ID="svctax_yn"   Checked="true" /> Check here to Enable Service tax Deatils for the Octroi MR detail <br />
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
                                                    <asp:TextBox ID="txtdeclval" Enabled="false" runat="server" BorderStyle="Groove"  Width="80" Columns="8"></asp:TextBox>
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
                                                    <asp:TextBox ID="txtoctper" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="60"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8"  
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
                                                    <asp:TextBox ID="txtstax"  Enabled="false" runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="40"  onblur="javascript:return calc()" BorderStyle="Groove" Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Cess">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtcess"  Enabled="false"  runat="server"  onblur="javascript:return calc()" BorderStyle="Groove" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                                           Width="40"  Columns="8" Text="0"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                HeaderText="Higher Edu. Cess">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txthcess"  Enabled="false"  runat="server" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
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
