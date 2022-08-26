<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelTripEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_FuelTripEdit" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript">

function SelectAllCheckboxes(spanChk){

   // Added as ASPX uses SPAN for checkbox
   var oItem = spanChk.children;
   var theBox= (spanChk.type=="checkbox") ? 
        spanChk : spanChk.children.item[0];
   xState=theBox.checked;
   elm=theBox.form.elements;

   for(i=0;i<elm.length;i++)
     if(elm[i].type=="checkbox" && 
              elm[i].id!=theBox.id)
     {
       //elm[i].click();
       if(elm[i].checked!=xState)
         elm[i].click();
       //elm[i].checked=xState;
     }
 }
 
  function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
        if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
        // IE
        else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkTripsheetno(txtTripsheetNo)
    {
        var currentTime = new Date()
        
        if (txtTripsheetNo.value == "")
        {
            return true;    
        }
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    //alert("1 : " + returnValue[0])
                    if (returnValue[0] == "N") 
                    {  
                        alert("Invalid TripSheet No.");
                        document.getElementById("ctl00_MyCPH1_txtTripsheetNo").value="";
                        document.getElementById("ctl00_MyCPH1_txtTripsheetNo").focus();
                        return false;
                    }
                    else
                    {
                        var jDriverSettleDt="";
                        jDriverSettleDt = returnValue[2]; 
                        
                         if(jDriverSettleDt != "")
                        {
                             alert("This Tripsheet is Already Settled");          
                             document.getElementById("ctl00_MyCPH1_txtTripsheetNo").focus();
                             return true;     
                        }    
                    }
                }
            }
             xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckTripsheetNo&datetime="+currentTime+"&TripsheetNo=" + txtTripsheetNo.value, false);
             xmlHttpRequest.send(null);
        }	
    } 
    
function CheckOpClose()
{  
    var txtTripsheetNo = document.getElementById("ctl00_MyCPH1_txtTripsheetNo");

    if(txtTripsheetNo.value == "")
    {
        alert("Enter Tripsheet No!!!");
        txtTripsheetNo.focus();
        return false;
    }
}

function CheckTrip(txtNewTripsheetNo)
{
    var currentTime = new Date()
    var grid=document.getElementById("ctl00_MyCPH1_gvFuelTripEdit");
    
    if (txtNewTripsheetNo.value == "")
    {  
       return true;
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
                    alert("Invalid Tripsheet No.");
                    txtNewTripsheetNo.focus();
                    return false;
                }
                else
                {
                    var jDriverSettleDt="";
                    jDriverSettleDt = returnValue[2]; 

                     if(jDriverSettleDt != "")
                    {
                         alert("This Tripsheet is Already Settled");          
                         txtNewTripsheetNo.focus();
                         return true;     
                    } 
                    else
                    {
                        
                    }
                    
                }
            }
        }
       xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckTrip&datetime="+currentTime+"&TripsheetNo=" + txtNewTripsheetNo.value, false);
       xmlHttpRequest.send(null);     
    }
}

function CheckSubmit()
{
        var grid=document.getElementById("ctl00_MyCPH1_gvFuelTripEdit");
        var rows=0;
        rows = parseInt(grid.rows.length);
        rows++;
        var cnt=0;
        var pref="";
        for(var i=2;i<rows;i++)
        {
            if(i<10)
                pref= "ctl00_MyCPH1_gvFuelTripEdit_ctl0" + i + "_";
            else
                pref= "ctl00_MyCPH1_gvFuelTripEdit_ctl" + i + "_";

                var txtNewTripsheetNo=document.getElementById(pref + "txtNewTripsheetNo");
                var chkyes =document.getElementById(pref + "chkSelect");
                if(chkyes.checked==true)
                {
                    cnt++;
                    if(txtNewTripsheetNo.value=="")
                    {
                        alert("Please Enter New Tripsheet No.");
                        txtNewTripsheetNo.focus();
                        return false;
                    }
                
                } // chkyes checked
           
        } // i for loop
        
        if(cnt==0)
        {
            alert("Please Select Atleast one Tripsheet No.");
            return false;
        }
        
        return true;
}
 
</script>  

<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop); height: 36px; width: 177px;"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>

 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet > Trip Finances > Fuel Trip Edit </asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
     
            <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="UpdatePanel1">
                 <ContentTemplate>
            <table cellspacing="1" style="width: 7.5in" class="boxbg" align="left">
                <tr class="bgbluegrey">
                    <td colspan="3" align="center" style="height: 21px">
                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server"> Fuel Trip Edit </asp:Label>
                    </td>
                </tr>
                <tr  bgcolor="white">   
                    <td width="5%" nowrap style="vertical-align: top; width: 154px; text-align: left" class="blackfnt"><strong>Enter TripsheetNo.</strong></td>
                   <%-- <td align="right" style="vertical-align: top; width: 154px; text-align: left" class="blackfnt"><strong>Enter No of Rows</strong></td>--%>
                    <td align="left" class="blackfnt" 
                        style="vertical-align: top; width: 100px; text-align: left">
                      <asp:TextBox ID="txtTripsheetNo" runat="server" Width="262px" TextMode="MultiLine" MaxLength="100"  BorderStyle="Groove" ></asp:TextBox>
                      </td>
                      <td align="left" class="blackfnt" colspan="1" style="vertical-align: top; width: 154px; text-align: left">   
                       <asp:Button ID="btngo" runat="server" OnClientClick="javascript:return CheckOpClose()" Width="70" Text="Go" OnClick="btngo_Click" />  
                    </td>
                    </tr> 
                    
                   <tr style="background-color: white">
                   <td align="right"  colspan="3" style="text-align: Right; width: 3%; height: 17px;">    
                   <%--OnRowDataBound="gvFuelTripEdit_RowDataBound"--%>           
                        <asp:GridView ID="gvFuelTripEdit"  runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="100%"  OnPageIndexChanging="gvFuelTripEdit_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField>
                                <HeaderTemplate>
                                     <input type="checkbox" id="chkAll" name="chkAll" onclick="javascript:SelectAllCheckboxes(this);" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" AutoPostBack="true" OnCheckedChanged="Clicked_Checkbox"/>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TRIPSHEETNO" HeaderText="Tripsheet No."> 
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="New Tripsheet No">
                                <ItemStyle Width="300px" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNewTripsheetNo" Visible="false" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="VEHICLENO" HeaderText="Vehicle No." >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Place" HeaderText="Place">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FuelType" HeaderText="Fuel Type">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Last_Km_Read" HeaderText="Last KM Reading">
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                  <asp:BoundField DataField="KM_Reading" HeaderText="Current KM Reading">
                                    <ItemStyle HorizontalAlign="Right" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BillNo" HeaderText="Slip No.">
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BillDt" HeaderText="Slip Date">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Diesel_Ltr" HeaderText="Diesel(Qty in Litres)">
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Diesel_Rate" HeaderText="Diesel(Rate/Litres)">
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Amount" HeaderText="Amount">
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EXE_AMT" HeaderText="Amount Approved By Fleet Exe.">
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               <asp:BoundField DataField="Remark" HeaderText="Remarks">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Vendor_Billno" HeaderText="Bill No.">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                         
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>     
                </td>
                </tr>
                
               <tr style="background-color: white">
                   <td align="left" colspan="3" >
                     <asp:Button ID="btnShow" runat="server" Text="Submit" Visible="false" OnClick="btnShow_Click" OnClientClick="javascript:return CheckSubmit()" />       
                   </td>
               </tr>
               
                <tr style="background-color: white">
                   <td align="left" colspan="3" >
                      <asp:Label ID="lblerror" runat="server" CssClass="bluefnt" Font-Bold="true"  Text=""></asp:Label>
                   </td>
               </tr>
              
            </table>
            </ContentTemplate>
        </asp:UpdatePanel>     
                
     
</asp:Content>

