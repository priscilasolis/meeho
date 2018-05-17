require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { description: @event.description, end_date: @event.end_date, max_students: @event.max_students, name: @event.name, start_date: @event.start_date } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { description: @event.description, end_date: @event.end_date, max_students: @event.max_students, name: @event.name, start_date: @event.start_date } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end

  test "get register form" do
    get register_to_event_url(@event)
    assert_response :success
    assert_select "label", "Email"
  end

  test "submit register form" do
    post register_user_url(@event), params: { email: 'psolis@nearsoft.com' }
    assert_response :redirect
    assert_equal @event.users.last.email, 'psolis@nearsoft.com'
  end

end
