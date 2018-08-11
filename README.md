# SmartAdapters

[![Gem Version](https://badge.fury.io/rb/smart_adapters.svg)](https://badge.fury.io/rb/smart_adapters)

Smart Adapters were born from the need to fully decouple the controller logic from the rendering of the response.
In the [Ruby on Rails documentation](https://apidock.com/rails/ActionController/MimeResponds/InstanceMethods/respond_to), the controller has to decide the format of the answer based on the (Content-Type) request:

```ruby
# app/controllers/people_controller.rb
def index
  @people = Person.all
  respond_to do |format|
    format.html
    format.xml { render :xml => @people.to_xml }
  end
end
```

Although, this method looks simple it's already highlighting how two distinct formats might have a slightly different implementation. The problem here is that over time this controller might inherit unnecessary complexity by simply introducting new properties or formats.

The Smart Adapters solve this problem by delegating the task of properly render the response based on the request format to well-defined classes, one per format. The following implementation makes use of the Smart Adapters:

```ruby
# app/controllers/people_controller.rb
def index
  current_adapter.success Person.all
end

# app/models/smart_adapters/people/index/html_adapter.rb
def success(people)
  render 'people/show', locals: { people: people }
end

# app/models/smart_adapters/people/index/xml_adapter.rb
def success(people)
  render xml: people, status: :ok
end
```

Now that the application has a class per format, it is easy to keep the controller dry while implementing format specific features. For instance, in case of an XML request, the adapter could add more details to the `people` collection or track some metrics without bloating the controller.

```ruby
# app/models/smart_adapters/people/index/xml_adapter.rb
def success(people)
  metric_tracker.push('New XML request')
  people.filter_private_details!
  render xml: people, status: :ok
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'smart_adapters'
```

And then execute:
```bash
$ bundle
```

Update the `ApplicationController` by adding the `SmartAdapters` concern:
```ruby
class ApplicationController < ActionController::Base
  include SmartAdapters
end
```

Add the adapters for your **controller/action/format**.

### Example

`app/controlles/users_controller.rb`
```ruby
class UsersController < ApplicationController
  # GET /users
  def index
    current_adapter.success User.all
  end

  # GET /users/1
  def show
    if user
      current_adapter.success(user)
    else
      current_adapter.failure(user)
    end
  end

  # PATCH/PUT /users/1
  def update
    if user.update_attributes(update_params)
      current_adapter.success(user)
    else
      current_adapter.failure(user)
    end
  end

  private

  def update_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end
end
```
`app/models/smart_adapters/users/index/html_adapter.rb`
```ruby
module SmartAdapters
  module Users
    module Index
      class HtmlAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Html::Default

        def success(resource)
          render 'users/show', locals: { resource: resource }
        end
      end
    end
  end
end
```
`app/models/smart_adapters/users/index/json_adapter.rb`
```ruby
module SmartAdapters
  module Users
    module Index
      class JsonAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Json::Default

        def success(resource)
          render json: resource, status: :ok
        end
      end
    end
  end
end

```
`app/models/smart_adapters/users/show/html_adapter.rb`
```ruby
module SmartAdapters
  module Users
    module Show
      class HtmlAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Html::Default

        def success(resource)
          render 'objects/show', locals: { resource: resource }
        end

        def failure(resource)
          redirect_back fallback_location: root_path, flash: { error: 'Resource not found' }
        end
      end
    end
  end
end
```
`app/models/smart_adapters/users/show/json_adapter.rb`
```ruby
module SmartAdapters
  module Users
    module Show
      class JsonAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Json::Default

        def success(resource)
          render json: resource, status: :ok
        end

        def failure(resource)
          render json: {}, status: :not_found
        end
      end
    end
  end
end
```
`app/models/smart_adapters/users/update/html_adapter.rb`
```ruby
module SmartAdapters
  module Users
    module Update
      class HtmlAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Html::Default

        def success(resource)
          render 'objects/show', locals: { resource: resource }
        end

        def failure(resource)
          unless resource.present?
            return redirect_back fallback_location: root_path, flash: { error: 'Resource not found' }
          end
          return redirect_back fallback_location: root_path, flash: { error: resource.errors }
        end
      end
    end
  end
end
```
`app/models/smart_adapters/users/update/json_adapter.rb`
```ruby
module SmartAdapters
  module Users
    module Update
      class JsonAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Json::Default

        def success(resource)
          render json: resource, status: :ok
        end

        def failure(resource)
          return render json: {}, status: :not_found unless resource.present?
          render json: { errors: resource.errors }, status: :bad_request
        end
      end
    end
  end
end
```

## TODO
- Add remaining formats: `:text`, `:ics`, `:csv`, `:yaml`, `:rss`, `:atom`
- Add generator
