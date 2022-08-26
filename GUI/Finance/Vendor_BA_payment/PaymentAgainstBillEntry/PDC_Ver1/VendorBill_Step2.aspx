<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VendorBill_Step2.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_RunSheet_VendorBill_Step2" EnableEventValidation="false" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
     <script language="javascript" type="text/javascript">
        
        function CheckPDCSelection(txtdocketlist,txtdocketlist_count)
        {
            //Get count of records fetched
           
            var mTotalRecords = "<%=intTotalRecords %>"
            //Get the selected control Name
            //Normally, ID and Name values are same
            //var mSelectedControlName = objBranch.name;
            //Will store dynamically generated control name
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
                //alert(mTotalRecords)
            //Loop through the records
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
            
                if(j < 10)
                {
                
                    mDerivedControlName = "ctl00$MyCPH1$docdata$ctl" + "0" + j + "$chkDock"
                    //alert(mDerivedControlName)
                    
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$docdata$ctl" + j + "$chkDock"
                    
                }
                
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one Document for Generate Bill....!");
                
                return false;
            }
//            document.form1.txtdocketlist_count.value=mSelection
//           document.form1.txtdocketlist.value=mSelectedDockets;

            txtdocketlist.value=mSelection
            txtdocketlist_count.value=mSelectedDockets;
           //alert("hi-" +  document.form1.txtdocketlist.value)
            
            return true;
        }
        
        
        
        function CheckPDCSelection(txtdocketlist,txtdocketlist_count)
        {
            //Get count of records fetched
           
            var mTotalRecords = "<%=intTotalRecords %>"
            //Get the selected control Name
            //Normally, ID and Name values are same
            //var mSelectedControlName = objBranch.name;
            //Will store dynamically generated control name
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
                //alert(mTotalRecords)
            //Loop through the records
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
            //alert(i);
                if(j < 10)
                {
                
                    mDerivedControlName = "ctl00$MyCPH1$PDC$ctl" + "0" + j + "$chkDock"
                    //alert(mDerivedControlName)
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$PDC$ctl" + j + "$chkDock"
                }
                
                //Populate Docket No.s for Preaparing Loading Sheet
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one Document for Generate Bill....!");
                
                return false;
            }
//            document.form1.txtdocketlist_count.value=mSelection
//           document.form1.txtdocketlist.value=mSelectedDockets;
            txtdocketlist.value=mSelection
            txtdocketlist_count.value=mSelectedDockets;
           //alert("hi-" +  document.form1.txtdocketlist.value)
            
            return true;
        }
        function checkall(obj,type)
           {
            
           
                GridId="PDC";
            
             var mTotalRecords = "<%=intTotalRecords %>"
            
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$chkDock"
                                
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + j + "$chkDock"
                               
                            }
                            
                            if(obj.checked==true)
                            {
                            document.getElementById(chk_ind).checked=true;
                            }
                            else
                            {
                             document.getElementById(chk_ind).checked=false;
                            }
                       }
                   
            }
            function checkall_ind(type)
            {
             
                GridId="PDC";
            
                var mTotalRecords = "<%=intTotalRecords %>";
                var chk_cnt=0;
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$chkDock"
                                
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + j + "$chkDock"
                               
                            }
                            
                               if(document.getElementById(chk_ind).checked==true)
                               {
                                    chk_cnt=chk_cnt+1
                               }
                                                       
                       }
                        if(parseFloat(chk_cnt)==parseFloat(mTotalRecords))
                        {
                            document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl01$chkall").checked=true
                        }
                        else
                        {
                            document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl01$chkall").checked=false
                        }
                     
            }
    </script>
     
     

    <form id="form1">
    <div>
    <table cellspacing="1" style="width:10in" border="0" align="left" >
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <font class="blackfnt"><b><a href="../../welcome.aspx"><font class="blklnkund"><strong>
                    Module</strong></font></a><strong> &gt; </strong></font><font class="blackfnt">
                        <strong>Vendor Payment</strong> </font>&gt; <font class="bluefnt"><strong>Vendor Bill Entry </strong>
                        </font>
            </td>
        </tr>
        
        <tr>
            <td>
                <img src="../../../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr align="center">
            <td style="height: 100%" align="center" colspan="3">
    <p align="center"><font class="blackfnt"><b>You Selected</b></font></p>
    
    <table border="0" cellpadding="3" cols="1" width="65%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
     
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt" >Document Date</font></div>
        </td>
        <td  width="343" align="left"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt">Document Type</font> 
            </div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblDocType" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt">Document No</font> 
            </div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblDocNo" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
     <tr bgcolor="#FFFFFF"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt">Vendor Type</font> 
            </div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblVendorType" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt">Vendor</font> 
            </div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblVendor" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
    
  </table>
    <br />
   </td></tr>
   <tr> <td align="center">
   <font class="blackfnt" ><b>Select Documents for Billing</b></font>
                       
              </td></tr>
                 <tr><td>
                          <br />
                          
                           <%--Data Grid --%>
                           
                           <asp:GridView align="center" ID="docdata" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="Center"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="docdata_SelectedIndexChanged" Width="723px" Visible="false">
<Columns >
 
  <asp:TemplateField>
 
                <ItemTemplate>
                    <center>
                    <input type="checkbox" id="chkDock" onclick="javascript:checkall_ind()"  runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"THCNO") %>' />
                  <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                    </center>
                </ItemTemplate>
     </asp:TemplateField>




<asp:BoundField DataField="THCNO" HeaderText="Document Number " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="doctypenew" HeaderText="Document Type " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="THCDT" HeaderText="Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="PCAMT" HeaderText="Amount " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="THCBR" HeaderText="Started at" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>


<asp:GridView align="center" ID="PDC" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="100" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" Width="723px"  Visible="false">
<Columns >
  <asp:TemplateField>
   <HeaderTemplate>
                    <center>
                    <input type="checkbox" id="chkall"  runat="server" class="input" onclick="javascript:checkall(this)"   />
            
                    </center>
 </HeaderTemplate>
                <ItemTemplate>
                    <center>
                    <input type="checkbox"  onclick="javascript:checkall_ind()"  id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"PDCNO") %>' />
                  <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                    </center>
                </ItemTemplate>
     </asp:TemplateField>




<asp:BoundField DataField="PDCNO" HeaderText="Document Number " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="doctypenew" HeaderText="Document Type " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="PDCDT" HeaderText="Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="BALAMT" HeaderText="Amount " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="PDCBR" HeaderText="Started at" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>




<br />
                          
       <asp:HiddenField ID="txtdocketlist" runat="server" />
       <asp:HiddenField ID="txtdocketlist_count" runat="server" />
    <center>
         <%-- <asp:Button ID="Button1" runat="server"  CssClass="blackfnt" Text="Submit" OnClick="Button1_Click" Visible="false" />--%>
        <asp:Button ID="Button2" runat="server"  CssClass="blackfnt" Text="Submit" OnClick="Button2_Click"  Visible="false"/>
    </center>
                   
        </td>
                    </tr>
                </table>
    </div>
    </form>
</asp:Content>
