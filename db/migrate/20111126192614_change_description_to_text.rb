class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_column :sections, :description, :text

    Section.where(:name => "Vision").update_all(:description => 'The vision is a short, easy to understand statement that should describe your idealized 
perception of what your business will look to others.  

In summary it answers the question, "Where do we want to go?"

*Amazon*

bq. "To be the world''s most customer-centric company."

*Ben & Jerrys*

bq. "Making the best possible ice cream, in the nicest possible way"

*Cold Stone Creamery*

bq. "The ultimate ice cream experience."

*Disney*

bq. "To make people happy."

*General Electric(GE)*

bq. "We bring the good things to Life"

*Microsoft*

bq. "To enable people and businesses throughout the world realise their potential"')

Section.where(:name => "Mission").update_all(:description => 'The mission defines the purpose of the venture.  What your business will do, 
it''s market niche, growth plans, unique value prop.

The difference between a mission statement and a vision statement is that a mission statement focuses on a company''s present state while a vision statement focuses on a company''s future. 

*Apple*

bq. Apple is committed to bringing the best personal computing experience to students, educators, creative professionals and consumers around the world through its innovative hardware, software and Internet offerings.

*Facebook*

bq. Facebook''s mission is to give people the power to share and make the world more open and connected.

*Google*

bq. Google''s mission is to organize the world''s information and make it universally accessible and useful.

*YouTube*

bq. YouTube''s mission is to provide fast and easy video access and the ability to share videos frequently')
    
Section.where(:name => "Objectives").update_all(:description => '*Examples*

* First year revenue $1,900,000.
* Achieve profit before tax of $XXX,XXXX for year ending 12/31/XX.
* Obtain second round financing of $1.5 million by 5/15/XX.
* Sign up 100 beta test customers by end of Q4.
* Introduce new internet product by Mar 31; achieve Q2 sales of $25m, Q3 $50m, Q4 $85m
* Increase sales per employee from $250,000 to $300,000.
* Reduce Accounts Receivable from 60 days to 45 days by 6/30/XX.')

Section.where(:name => "Strategies").update_all(
:description => '*Examples*

* Partners: Align with industry leader, partner for marketing & solution development.
* Product Approach: Configure rather than customize; business rules vs custom programs.
* Competitive Positioning: Optimize user-based pricing; modular systems for flexibility
* R&D: Workflow solutions, open systems, multi-platform, object-oriented, flexible.
* Develop Employee Incentive Programs to allow the team to share in the rewards.

')

Section.where(:name => "Plans").update_all(
:description => '*Examples*

* Develop operating budget and plans for capital needs for the business by 1/1/XX.
* Contact 2 potential investors with One Page Business Plan by 2/1/XX.
* Purchase display booth for trade shows by 2/10/XX.
* Display products at 4 major trade shows during first half of the year, resulting in $500,000 in new revenue in 20XX
* Develop comprehensive Employee Recruitment and Retention Program by 1/15.
* Implement Power Partner Initiatives w/Google and Facebook by 2/28.
* Complete beta test of new site by 04/15.
* Launch social media program by 07/31.
* Complete facilities upgrades in Dallas by 08/31, London by 10/31.')
  end
end
