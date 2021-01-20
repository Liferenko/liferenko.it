defmodule TodayILearned do
  use GenServer
  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  # Client or interface
  def add_post(server_pid, new_post_data) do
    GenServer.cast(server_pid, {:add_post, new_post_data})
  end

  def get_all_posts(server_pid) do
    GenServer.call(server_pid, :get_posts)
  end
  
  #def update_post(server_pid, post_id) do
  #end
  
  # Callbacks
  def handle_cast({:add_post, new_post_data}, post_list) do
    {:noreply, TodayILearned.add_post(post_list, new_post_data)}
  end
   
  def handle_cast({:update_post, updated_data}, post_list) do
    {:noreply, TodayILearned.update_post(post_list, updated_data)}
  end

  def handle_call(:get_posts, _from, post_list) do
    {:reply, TodayILearned.get_all_posts(post_list), post_list}
  end

  def handle_info(:process_init, post_list) do
    IO.inspect("List of posts is ready")
    {:noreply, post_list}
  end
  def handle_info(msg, post_list) do
    IO.inspect("Invalid message: #{msg}")
    {:noreply, post_list}
  end
  
  # Server
  def init(_) do
    send(self(), :process_init)
    {:ok, TodayILearned.new()}
  end

end
