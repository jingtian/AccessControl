AccessControl
=============

AccessControl is a user authorization plugin. It gives you a role based permission system without having to do any work. There are users and roles, each have permission.
A user can play any role and inherit permissions through that role. A user may also have individual permissions. For example, you can create a role to update
the news section on your site and give a user that role. You may also give him permission to update contact information. Combining these two functionalities gives you 
a rich permission system inside your application.

Features
---------
* Role Based
* Easy to query permission (example: @current_user.can_manage_news?)
* God permission
* Easy to use

Up and Running
================

Install
-------

First, prepare your application. AccessControl does not create user logins, it soley is a permission system. Your user model must be named User. AccessControl
also uses two other models: Permission & Role. Once your users can login and log out, you are ready to use AccessControl.

1. Install
		(plugin) ./script/plugin install git://github.com/Adman65/AccessControl.git
		(gem) sudo gem install Adman65-AccessControl
		(gem) config.gem 'Adman65-AccessControl', :lib => 'access_control'		

2. Prepare the database
		./script/generate access_control models
		rake db:migrate

Step 2 creates a migration that creates one join table, role, and permission table. Migrate your database and you are ready to start working with permissions.


Working with Permissions
-------

Each permission you need in your application is a column in the permission model. Once again, we use a migration to create our permission. 
		./script/generate access_control permission NameOfYourPermission
		./script/generate access_control permission YourFirstPermission YourSecondPermission YourThirdPermission
		
The first creates a named migration. As you can see from the second example you can also create multiple permissions at once. Now, install your permissions:
		rake db:migrate
		
You're permissions are now ready. They can be attached to a user or a role. Now, you need to tell your user model that is has access controls:
		class User < ActiveRecord::Base
			has_access_controls
			# some more code
		end

And that's it! You are now ready to start granting and creating your authorization structure. First, lets focus on our users. 
Let us assume that there is a permission named PostNews. In your application, permissions are passed in underscore notation so post_news is correct.
Let's give a user this permission:
		user = User.find_by_name "Adam", "Hawkins"
		user.can_post_news? 
		user.grant :post_news
		user.can_post_news?

Voilla, Adam can now post_news. But that's no good by itself. So now check aganist for the permission in the controller:
		class NewsController < ActionController::Base
			before_filter permission_required(@current_user, :post_news)
		end
		
Your controllers are protected from people who can't post news. Now lets expand our permissions by adding a role:
		editors = Role.create :name => "Editors", :description => "Manage content around the site." # Description is optional
		# assuming we have these permissions in the system
		editors.grant :manage_news
		editors.grant :manage_categories
		editors.grant :manage_comments
		editors.grant :ban_users
		# now we need adam to be an editor
		user.plays :editor
		user.can_manage_news? (true)
		user.can_manage_categories? (true)
		user.can_manage_comments (true)
		user.can_ban_users? (true)
		
Man, Adam sure got a lot of responsibilities, hopefully you trust him :)


Using the language
==============

Here are the methods available on User & Role objects:
	Authorizable#authorize(permission)
	Authorizable#grant(permission)
	Authorizable#deauthorize(permission)
	Authorizable#cannot?(permission)
	Authorizable#god?
	Authorizable#can_permission_name?
	Authorizable#can_not_permission_name?
	Authorizable#permissions
	Authorizable#has_permission?(permission)
	Authorizable#can?(permission)
	
User Methods:
	User#plays?(role)
	User#plays(role)
	User#does_not_play?(role)
	User#does_not_play(role)
	User.roles (and all other has_and_belongs_to_many methods)


Copyright (c) 2009 Adam Hawkins, released under the MIT license
