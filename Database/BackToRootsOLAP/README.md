<a name="top"></a>

# Back to Roots Bakery OLAP
[Executive Summary](#ExecutiveSummary) | [Business Requirements](#BusinessRequirements) | [Data Mart Design](#DataMartDesign) |
<br>[Build Script](#BuildScript) | [ETL](#ETL) | [Download and Explore!](#DownloadExplore)

<a name="ExecutiveSummary"></a>
## Executive Summary
Back-to-Roots Bakery is a health-conscious, community-centered bakery focused on helping people feel their best while still enjoying “going for ice cream.” The bakery makes and sells a variety of treats and comfort foods for in-store ordering, pre-ordered pick-up, and delivery. Orders can be placed using a variety of methods, including in-store, by phone, and online. In 2018, Back-to-Roots Bakery opened their first location in Boulder, Colorado and recently opened a new location in Longmont, Colorado. With this expansion, the bakery has seen an increase in demand.
<br>
<br>The Back-to-Roots OLTP gives Back-to-Roots Bakery the competitive advantage, customer insights, process optimization, and data-driven decision-making capabilities to compete in an increasingly competitive industry and to maximize their potential. However, Back-to-Roots has grown beyond their needs for a traditional OLTP, and due to the volume of data coming into the Back-to-Roots OLTP, the need to create a data mart is realized for the following reasons: (1) optimize reporting, (2) archive data, and (3) consolidate data. With particular emphasis on optimizing reporting, a data mart will allow faster reporting design and results at Back-to-Roots Bakery, empowering a focus on analysis and data-driven decision making to continue competing in the industry and maximizing potential, building upon the goals and benefits of the OLTP.
<br>

<a name="BusinessRequirements"></a>
## Business Requirements
<b>Chief Operating Officer (COO):</b> <i>What is the quantity of sales monthly, seasonally, and yearly summarized by product, product type, and diet, in addition to location and order fulfillment?</i>
<blockquote>This analysis will allow the COO to understand demand for products and order fulfillment at each location, informing decisions regarding what products should be stocked and which order fulfillment methods should be supported for those products.</blockquote>

<b>Hiring Manager:</b> <i>What are the sales monthly, quarterly, and yearly summarized by location, position name, and employee, with an indicator for number of days worked by the employee?</i>
<blockquote>This analysis will inform the hiring manager of the sales brought in by each employee, including location, position, and days worked information. This provides information regarding employee performance in terms of sales, informing decisions on allocation of support resources (including training), promotion, wage, and firing.</blockquote>

<b>Chief Marketing Officer (CMO):</b> <i>What are the sales monthly, quarterly, and yearly summarized by customer age and reward status, in addition to order placement method?</i>
<blockquote>This analysis will allow the CMO to understand the demographics, loyalty, and order placement habits of customers in terms of sales. This information will inform marketing and promotion decisions to reach customers and establish loyalty, in addition to the development and support of the appropriate order placement platforms.</blockquote>

<a name="DataMartDesign"></a>
## Data Mart Design
### Information Package

![BackToRootsDMInformationPackage](https://user-images.githubusercontent.com/91146906/138394990-ba725c47-4bd2-4478-aa8c-23640d321c27.png)

### Snowflake Schema

![BackToRootsDMSnowflakeSchema](https://user-images.githubusercontent.com/91146906/138395442-53585d50-d802-4794-bf6c-3b6ec1aeb7df.png)

<a name="BuildScript"></a>
## Build Script
The Back to Roots data mart build script creates the "BackToRootsDM" data mart if it does not exist, deletes tables if they exist, and creates dimension tables and the fact table with the appropriate attributes and constraints. Due to the logic, the script can be run multiple times without error.
<br>
<br><i>See the BuildBackToRootsDM.sql build script [here](../BackToRootsOLAP/BuildBackToRootsDM.sql).</i>
