- dashboard: management_dashboard
  title: "Sales & Marketing Leadership"
  layout: tile
  tile_size: 100

  filters:
 
  - name: lead_source
    type: field_filter
    explore: lead
    field: lead.lead_source
  
  elements:
  
  - name: total_active_customers
    title: 'Total Active Customers'
    type: single_value
    model: salesforce
    explore: account
    measures: [account.customer_count]
    filters:
      account.type: '"Paying Customer"'
    sorts: [account.customer_count desc]
    font_size: medium
    text_color: '#49719a'
    height: 2
    width: 4
    
  - name: total_revenue_this_quarter
    title: 'Total Revenue Closed (Quarter-to-Date)'
    type: single_value
    model: salesforce
    explore: opportunity
    measures: [opportunity.amount]
    filters:
      opportunity.close_date: this quarter
      opportunity.stage_name: '"Closed - WON"'
    sorts: [opportunity.amount desc]
    font_size: medium
    text_color: black
    height: 2
    width: 4
    
  - name: average_deal_size_this_quarter
    title: 'Average Deal Size (Quarter-to-Date)'
    type: single_value
    model: salesforce
    explore: opportunity
    measures: [opportunity.average_deal_size]
    filters:
      opportunity.close_date: this quarter
      opportunity.stage_name: '"Closed - WON"'
    sorts: [opportunity.average_deal_size desc]
    font_size: medium
    text_color: black
    height: 2
    width: 4    
  
  - name: lead_to_win_funnel_this_quarter
    title: 'Lead to Win Funnel (Quarter-to-Date)'
    type: looker_column
    model: salesforce
    explore: lead
    measures: [lead.count, opportunity.count_new_business, opportunity.count_new_business_won]
    filters:
      lead.status: -%Unqualified%
      lead.created_date: this quarter
    listen:
      lead_source: lead.lead_source
    sorts: [lead.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#635189', '#a2dcf3', '#1ea8df']
    show_value_labels: true
    label_density: 10
    label_color: ['#635189', '#a2dcf3', '#1ea8df']
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    series_labels:
      lead.count: Leads
      opportunity.count_new_business: Opportunities
      opportunity.count_new_business_won: Won Opportunities
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    height: 4
    width: 6
    
  - name: deals_closed_by_segment
    title: 'Deals Closed by Segment'
    type: looker_area
    model: salesforce
    explore: opportunity
    dimensions: [opportunity.close_month, account.business_segment]
    pivots: [account.business_segment]
    measures: [opportunity.count]
    filters:
      opportunity.close_month: before tomorrow
      opportunity.stage_name: '"Closed - WON"'
    sorts: [opportunity.close_month, account.business_segment, account.business_segment__sort_]
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 6

  - name: prospects_by_forecast_category_and_segment
    title: 'Prospects by Forecast Category and Segment'
    type: looker_donut_multiples
    model: salesforce
    explore: opportunity
    dimensions: [account.business_segment, opportunity.forecast_category]
    pivots: [opportunity.forecast_category]
    measures: [account.count]
    filters:
      account.business_segment: -Unknown
      opportunity.stage_name: -%Closed%
    sorts: [opportunity.close_month, account.business_segment, account.business_segment__sort_,
      opportunity.forecast_category]
    limit: 500
    column_limit: 50
    show_value_labels: false
    font_size: 12
    show_view_names: true
    height: 4
    width: 6
    
  - name: pipeline_forecast
    title: 'Pipeline Forecast'
    type: looker_column
    model: salesforce
    explore: opportunity
    dimensions: [opportunity.probability_group, opportunity.close_month]
    pivots: [opportunity.probability_group]
    measures: [opportunity.total_revenue]
    filters:
      opportunity.close_month: 9 months ago for 12 months
    sorts: [opportunity.probability_group, opportunity.close_month, opportunity.probability_group__sort_]
    query_timezone: America/Los_Angeles
    stacking: normal
    hidden_series: [Under 20%, Lost]
    colors: [lightgrey, '#1FD110', '#95d925', '#d0ca0e', '#c77706', '#bf2006', black]
    show_value_labels: true
    label_density: 21
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    series_labels:
      '0': Lost
      100 or Above: Won
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Amount in Pipeline]
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Opportunity Close Month
    show_x_axis_ticks: true
    x_axis_datetime_label: '%b %y'
    x_axis_scale: ordinal
    ordering: none
    show_null_labels: false
    
    
  - name: sales_segment_performance
    title: 'Sales Segment Performance'
    type: looker_column
    model: salesforce
    explore: opportunity
    dimensions: [account.business_segment]
    measures: [account.count, opportunity.total_revenue]
    filters:
      account.business_segment: -Unknown
      opportunity.stage_name: '"Closed - WON"'
    sorts: [opportunity.close_month, account.business_segment, account.business_segment__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 12
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_orientation: [left, right]
    show_null_labels: false
    
  - name: closer_roster_and_total_pipeline_revenue
    title: 'Closer Roster By Average Annual Revenue and Total Pipeline Revenue'
    type: looker_column
    model: salesforce
    explore: opportunity
    dimensions: [opportunity_owner.name]
    measures: [opportunity.total_pipeline_revenue, opportunity.average_revenue_won]
    filters:
      opportunity_owner.name: -NULL
      opportunity.count_won: '>0'
    sorts: [opportunity_owner.name desc]
    limit: 12
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#635189', '#b3a0dd']
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    x_padding_right: 15
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_orientation: [right]
    x_axis_label_rotation: 0
    show_null_labels: false

  - name: sdr_roster_and_total_pipeline_revenue
    title: 'SDR Roster By Average Annual Revenue and Total Pipeline Revenue'
    type: looker_column
    model: salesforce
    explore: opportunity
    dimensions: [opportunity.sdr__who__passed___c]
    measures: [opportunity.total_pipeline_revenue, opportunity.average_revenue_won]
    filters:
      opportunity_owner.name: -NULL
      opportunity.count_won: '>0'
    sorts: [opportunity_owner.name desc]
    limit: 12
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#635189', '#b3a0dd']
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    x_padding_right: 15
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_orientation: [right]
    x_axis_label_rotation: 0
    show_null_labels: false
  
  - name: sdr_oppty_won
    title: "SDR Opportunities Won - Table"
    type: table
    model: salesforce
    explore: opportunity
    dimensions: [opportunity.created_month, opportunity.sdr__who__passed___c]
    pivots: [opportunity.sdr__who__passed___c]
    measures: [opportunity.count_open, opportunity.count_won, opportunity.count_lost,
      opportunity.count]
    dynamic_fields:
    - table_calculation: percent_won
      label: Percent Won
      expression: round(${opportunity.count_won}*100/${opportunity.count},2)
    hidden_fields: [opportunity.count_lost, opportunity.count_open]
    filters:
      opportunity.created_month: 5 months
      opportunity.sdr__who__passed___c: -%Becca%,-%Todd%,-%Shea%
    sorts: [opportunity.sdr__who__passed___c desc, opportunity.count desc 0]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: true
    color_palette: Looker Classic
    show_row_numbers: true
    point_style: circle
    interpolation: linear
    show_null_points: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    hidden_series: [Todd Busler - Opportunity Count Won, Todd Busler - Percent Won,
      Becca Lindquist - Opportunity Count Won, Becca Lindquist - Percent Won]

  - name: sdr_percent_won
    title: "SDR vs. None - Percent of Opportunities Won" 
    type: looker_line
    model: salesforce
    explore: opportunity
    dimensions: [opportunity.created_month, opportunity.sdr__who__passed___c]
    pivots: [opportunity.sdr__who__passed___c]
    measures: [opportunity.count_open, opportunity.count_won, opportunity.count_lost,
      opportunity.count]
    dynamic_fields:
    - table_calculation: percent_won
      label: Percent Won
      expression: round(${opportunity.count_won}*100/${opportunity.count},2)
    hidden_fields: [opportunity.count_lost, opportunity.count_open]
    filters:
      opportunity.created_month: 5 months
      opportunity.sdr__who__passed___c: -%Becca%,-%Todd%,-%Shea%
    sorts: [opportunity.sdr__who__passed___c desc, opportunity.count desc 0]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    hidden_series: [Niket Khanna - Opportunity Count Won, Niket Khanna - Opportunity Count,
      Carly Moore - Opportunity Count Won, Carly Moore - Opportunity Count, ∅ - Opportunity Count Won,
      ∅ - Opportunity Count]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: linear
