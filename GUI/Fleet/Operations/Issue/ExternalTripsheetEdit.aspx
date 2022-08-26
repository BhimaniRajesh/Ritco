<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"  CodeFile="ExternalTripsheetEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalTripsheetEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
   <script language="javascript" type="text/javascript">
   
   
   
   
 function formatDate(dateString)
 {
 var inputDate=dateString.split('/');
 return inputDate[1]+'/'+inputDate[0]+'/'+inputDate[2]
 }
function isDate(dateString){
var datePat=/^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
var matchArray=dateString.match(datePat);
if(matchArray==null)return false;
month=matchArray[1];day=matchArray[3];year=matchArray[5];
if(month<1||month>12)return false;if(day<1||day>31)return false;
if((month==4||month==6||month==9||month==11)&&day==31)return false;
if(month==2){var isleap=(year%4==0&&(year%100!=0||year%400==0));
if(day>29||(day==29&&!isleap))return false;}return true;
}

   
   function validation()
   {
   
      var grid1=document.getElementById("ctl00_MyCPH1_dgTHC");
        var r1=grid1.rows.length;
         
      
        var Toadydate= new Date(formatDate(document.getElementById("ctl00_MyCPH1_todDate").value));
      
          var tripdate=  new Date(formatDate(document.getElementById("ctl00_MyCPH1_hidTripDate").value));
    
    
       for(i=0;i< r1-2;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgTHC_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgTHC_ctl" + j + "_";
           
                }    
          
         var From=   document.getElementById(pref + "txtFrom").value;
         var  To1 =document.getElementById(pref + "txtTo").value;
         var  Thcno=document.getElementById(pref + "txtTHCNo").value;
         var  ThcDt=document.getElementById(pref + "txtTHCDt").value;
         var Frt= document.getElementById(pref + "txtFreightAmt").value;
         var Lab= document.getElementById(pref + "txtLabourChrg").value;
         var  Oth =document.getElementById(pref + "txtOtherChrg").value;
         
       
        
           if(From=="")
           {
           
           alert("Please Enter From City");
           document.getElementById(pref + "txtFrom").focus();
            return false;
           
           }
               
           if(To1=="")
           {
           
           alert("Please Enter To City");
           document.getElementById(pref + "txtTo").focus();
            return false;
           
           }
          if(Thcno=="")
          {
           
           alert("Please Enter  Thc No.");
           document.getElementById(pref + "txtTHCNo").focus();
            return false;
           
          }
          if(ThcDt=="")
           {
           
           alert("Please Enter  Thc Date.");
           document.getElementById(pref + "txtTHCDt").focus();
            return false;
           }
        
             var date = ThcDt.replace(/^\s+|\s+$/g, '') ;
         
             if (!isDate(formatDate(date)))
             {
             
              alert('Invalid THC Date');
              document.getElementById(pref + "txtTHCDt").focus();
              return false;
              } 
             
          var ThcDate=new Date(formatDate(document.getElementById(pref + "txtTHCDt").value));
         
         
   

         if (ThcDate > Toadydate)
        {
        alert("THC  Date cannot be future date");
         document.getElementById(pref + "txtTHCDt").focus(); 
         return false;
        } 
        
         if(ThcDate < tripdate)
        {
        alert("THC Date cannot be less than Tripsheet date");
         document.getElementById(pref + "txtTHCDt").focus(); 
         return false;
        } 
           
           
           if(Frt=="")
            {
           
           alert("Please Enter Freight Amount");
           document.getElementById(pref + "txtFreightAmt").focus();
            return false;
           }
           if(Lab=="")
             {
           
           alert("Please Enter Labour Charge");
           document.getElementById(pref + "txtLabourChrg").focus();
           return false;
           
           }
           if(Oth=="")
           {
           
           alert("Please Enter Other Charge");
           document.getElementById(pref + "txtOtherChrg").focus();
            return false;
           }
   
       }
   }
   
   
   
   function calculateBalance()
    {
    
    
      var totfrt="0.00",totlab="0.00",tototh="0.00",total="0.00";
      
       var grid1=document.getElementById("ctl00_MyCPH1_dgTHC");
        var r1=grid1.rows.length;
         
    
       for(i=0;i< r1-2;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgTHC_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgTHC_ctl" + j + "_";
           
                }    
          
          
            var frt=document.getElementById(pref + "txtFreightAmt");
            var lab=document.getElementById(pref + "txtLabourChrg");
            var oth=document.getElementById(pref + "txtOtherChrg");
         
    
    
    
  
         if(frt.value!="")
         {
           totfrt=parseFloat(totfrt) + parseFloat(frt.value);
         }
      
        if(lab.value!="")
         {
           totlab=parseFloat(totlab) + parseFloat(lab.value);
         }
       
         if(oth.value!="")
         {
           tototh=parseFloat(tototh) + parseFloat(oth.value);
         }
         
         
         if(frt.value=="")
         {
         frt.value=0;
         }
          if(lab.value=="")
         {
         lab.value=0;
         }
          if(oth.value=="")
         {
         oth.value=0;
         }
         
         
            document.getElementById(pref + "txtTHCTotalAmt").value=parseFloat(frt.value)+ parseFloat(lab.value)+parseFloat(oth.value);
            var tot=document.getElementById(pref + "txtTHCTotalAmt");
     
        if(tot.value!="")
         {
           total=parseFloat(total) + parseFloat(tot.value);
         }
  
            
    
     }
     
   
    var  mpref="";
   
    
      
           if(parseInt(r1)<=9)
           {
            var  mpref="ctl00_MyCPH1_dgTHC_ctl0" +r1 + "_";
    
           }
            if(parseInt(r1)>9)
            {
             var  mpref="ctl00_MyCPH1_dgTHC_ctl" + r1 + "_";
         
            }
      
      
      
           document.getElementById(mpref + "txtFrtTotal").value=totfrt;       
           document.getElementById(mpref + "txtLabTotal").value=totlab;
           document.getElementById(mpref + "txtOthTotal").value=tototh;       
           document.getElementById(mpref + "txtTotal").value=total;     
     
//     alert(document.getElementById(mpref + "txtFrtTotal").value);
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
        
   
   
   
   
  </script>
 
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> External Tripsheet Edit </asp:Label>
            </td>
              <td align="center">
       
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
         
          </td>      
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
 <br/> 

  
      <table cellspacing="1" align="center"  cellpadding="3" width="80%"     border="0">
            
            <tr style="background-color: white">
                <td   align="center" >
             
             
             
              
      <table cellspacing="1" cellpadding="3" width="100%" align="center" class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td   align="center">
          <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
      
                    </td>
               
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="EXTERNAL TRIPSHEET EDIT MODULE"></asp:Label></td>
                
            </tr>
             
             <tr style="background-color: white">
            
                <td align="left" >
                  <font class="bluefnt">Tripsheet No.</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueNo" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>Manual Tripsheet No.</font> 
                </td>
                <td align="left">
              
               <asp:Label ID="lblManual" runat="server" Width="100"  ></asp:Label>
                 
                </td>
            </tr>
            
               <tr style="background-color: white">
            
                <td align="left" >
                  <font class="bluefnt">Tripsheet Date</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblTripDate" runat="server" CssClass="blackfnt"></asp:Label>
               <asp:HiddenField  ID="todDate"  runat="server"></asp:HiddenField>
               <asp:HiddenField  ID="hidTripDate"  runat="server"></asp:HiddenField>
               
                </td>
                <td align="left">
                <font class=bluefnt>Vehicle No.</font>  
                </td>
                <td align="left">
 
               <asp:Label ID="lblVehicleNo" runat="server" Width="100"  ></asp:Label>
               
                </td>
            </tr>
            
          
               <tr style="background-color: white">
            
                <td align="left" >
                  <font class="bluefnt">Category</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblCategory" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
              <asp:Label ID="lblCustomer"  Visible="false"  Text="Customer" runat="server" CssClass="bluefnt"></asp:Label>
                <asp:Label ID="lblMarket"  Visible="false"   Text="Market/Own" runat="server" CssClass="bluefnt"></asp:Label>
                </td>
                <td align="left">
             
               <asp:Label ID="lblCust_Market"     runat="server" CssClass="blackfnt"></asp:Label>
               
                </td>
            </tr>
          
              
              <tr style="background-color: white" >
           
               <td align="left">
 
                <asp:Label ID="Label2"  Text="Billed Y/N"  runat="server" CssClass="bluefnt"></asp:Label>
                </td>
                <td align="left">
             
               <asp:Label ID="lblBilled"     runat="server" CssClass="blackfnt"></asp:Label>
               
                </td>
           
           
                 <td align="left" >
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Driver1 Manual Code</font>
                </td>
                <td align="left"  >
                   <font class="blackfnt">
                     <asp:Label ID="lblDriverCode"     runat="server" CssClass="blackfnt"></asp:Label>
              
                   </font>
                </td>
         
              </tr>
              
              
              
              
              
                        
        </table>
        </td>
        </tr>
       <tr style="background-color: white">
                <td   align="center" >
        
        
              <asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
    
            <table cellspacing="1" align="center"  cellpadding="3" style="width: 90%"     border="0">
            
            <tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddTHCrow" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))" OnTextChanged="add_rowTHC" AutoPostBack="true"></asp:TextBox></td>
            </tr> 
            
             <tr style="background-color: white">
                <td colspan=4 align="center">
                                     
 <asp:DataGrid ID="dgTHC" runat="server" AutoGenerateColumns="False" CellPadding="2"   ShowFooter="true"
                                                                        CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                                        BorderWidth="3px" Width="100%" OnItemDataBound="dgTHCDet_ItemDataBound">
                                                                        <Columns>
                                                                            <asp:TemplateColumn HeaderText="Sr.No.">
                                                                                <ItemTemplate>
                                                                                    <center>
                                                                                        <%# Container.ItemIndex+1 %>
                                                                                        .
                                                                                        <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                                    </center>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <FooterTemplate>
                                                                                    <asp:Label ID="lblBilled" runat="server" CssClass="blackfnt">Total</asp:Label>
                                                                                </FooterTemplate>
                                                                            </asp:TemplateColumn>
                                                                            <asp:TemplateColumn HeaderText="From">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtFrom" runat="server"   Width="150px"   
                                                                                        BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                                                                     <asp:RequiredFieldValidator ID="reqFrom" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtFrom"></asp:RequiredFieldValidator>
                                                                            
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                            </asp:TemplateColumn>
                                                                            <asp:TemplateColumn HeaderText="To">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtTo" runat="server" MaxLength="100" Width="150px"  
                                                                                        BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="reqTo" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtTo"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                            </asp:TemplateColumn>
                                                                            
                                                                            <asp:TemplateColumn HeaderText="THC No.">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtTHCNo" runat="server"   Width="100px"   
                                                                                        BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                                                                          <asp:RequiredFieldValidator ID="reqTHCNo" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtTHCNo"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                            </asp:TemplateColumn>
                                                                            
                                                                            <asp:TemplateColumn HeaderText="THC Date">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtTHCDt" runat="server"   Width="65px"   
                                                                                        BorderStyle="Groove" MaxLength="10" CssClass="input"></asp:TextBox>
                                                                                         <asp:RequiredFieldValidator ID="reqTHCDt" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtTHCDt"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                            </asp:TemplateColumn>
                                                                          <%--  AutoPostBack=true OnTextChanged="CalcTHCContractAmt"--%>
                                                                            <asp:TemplateColumn HeaderText="Freight Amount">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtFreightAmt" runat="server"   Width="60px"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                                        BorderStyle="Groove" MaxLength="6" CssClass="input" ></asp:TextBox>
                                                                                        
                                                                                        
                                                                                         <asp:RequiredFieldValidator ID="reqFreightAmt" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtFreightAmt"></asp:RequiredFieldValidator>
                                                                            
                                                                                    
                                                                        <asp:RegularExpressionValidator ID="RegFreightAmt" runat="server" ErrorMessage="!"
                                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtFreightAmt"
                                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                                                        
                                                                                        
                                                                                        
                                                                               </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                     <FooterTemplate>
                                                                                           <asp:TextBox ID="txtFrtTotal"   Width="60px" runat="server" Font-Bold="true" ReadOnly="true"  CssClass="blackfnt"></asp:TextBox>
                                                                                </FooterTemplate>
                                                                            </asp:TemplateColumn>
                                                                            
                                                                            
                                                                            <asp:TemplateColumn HeaderText="Labour charge">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtLabourChrg" runat="server"   Width="60px" onblur="javascript:return calculateBalance()"     onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                                        BorderStyle="Groove" MaxLength="6" CssClass="input"  ></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="reqLabourChrg" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtLabourChrg"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegLabourChrg" runat="server" ErrorMessage="!"
                                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtLabourChrg"
                                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                                            
                                                                               </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                     <FooterTemplate>
                                                                                          <asp:TextBox ID="txtLabTotal" Font-Bold="true" Width="60px"  runat="server"  ReadOnly="true" CssClass="blackfnt"></asp:TextBox>
                                                                                </FooterTemplate>
                                                                            </asp:TemplateColumn>
                                                                            
                                                                            <asp:TemplateColumn HeaderText="Other charge" >
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtOtherChrg" runat="server"   Width="60px"  onblur="javascript:return calculateBalance()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                                        BorderStyle="Groove" MaxLength="6" CssClass="input"  ></asp:TextBox>
                                                                                        
                                                                                        <asp:RequiredFieldValidator ID="reqOtherChrg" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtOtherChrg"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegOtherChrg" runat="server" ErrorMessage="!"
                                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtOtherChrg"
                                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                                            
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                     <FooterTemplate>
                                                                                    <asp:TextBox ID="txtOthTotal" runat="server"   Width="60px"  Font-Bold="true" ReadOnly="true" CssClass="blackfnt"></asp:TextBox>
                                                                                </FooterTemplate>
                                                                            </asp:TemplateColumn>
                                                                            
                                                                            <asp:TemplateColumn HeaderText="Total">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtTHCTotalAmt" runat="server"   Width="60px"  onblur="javascript:return calculateBalance()" ReadOnly="true" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" 
                                                                                        BorderStyle="Groove" MaxLength="6"  CssClass="input"></asp:TextBox>
                                                                                    <%--  <asp:HiddenField ID="hdTotal" runat="server"></asp:HiddenField>--%>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                    Font-Underline="False" Wrap="False" />
                                                                                     <FooterTemplate>
                                                                                          <asp:TextBox ID="txtTotal" runat="server" Font-Bold="true"  Width="60px"   ReadOnly="true" CssClass="blackfnt"></asp:TextBox>
                                                                                </FooterTemplate>
                                                                            </asp:TemplateColumn>
                                                                            
                                                                            
                                                                        </Columns>
                                                                        <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                                            ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                        <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle ForeColor="#000066" />
                                                                        <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                                    </asp:DataGrid>
                                              
                                    </td>
                                 </tr>
                                 
                                                          
                                                             
             </table>            
         
                      <br/>
       
      <p align="center">
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>"  Visible="true"  OnClientClick="javascript:return validation()"    OnClick="cmdSubmit_Click"   />
     </p> 
            
             </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtAddTHCrow" EventName="TextChanged" />
                   
                    </Triggers>
                    </asp:UpdatePanel>   
  </td>
     
     </tr>
                
     </table> 

</asp:Content> 

