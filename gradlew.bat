package com.demo.incampus.fragments.profile;

import android.app.Application;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.ViewModelProvider;
import androidx.paging.PagedList;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.demo.incampus.R;
import com.demo.incampus.activities.OtherCommunityProfileActivity;
import com.demo.incampus.activities.OtherProfileActivity;
import com.demo.incampus.adapters.HomeAdapter;
import com.demo.incampus.commongraphqlmodels.DeleteCommentUpvoteResponse;
import com.demo.incampus.commongraphqlmodels.DeletePostUpvoteResponse;
import com.demo.incampus.commongraphqlmodels.InsertCommentUpvoteResponse;
import com.demo.incampus.commongraphqlmodels.InsertPostUpvoteResponse;
import com.demo.incampus.interfaces.Api;
import com.demo.incampus.network.GraphqlClient;
import com.demo.incampus.pagination.home.Home_Post_Response;
import com.demo.incampus.pagination.profile.viewmodel.UserViewModelFactory_Profile_Posts;
import com.demo.incampus.pagination.profile.viewmodel.UserViewModel_Profile_Posts;
import com.google.gson.JsonObject;
import com.like.LikeButton;

import java.util.Objects;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ProfilePostsFragment extends Fragment {

    //Initiate Variables
    View view;
    public static final Api api = GraphqlClient.getApi();
    private static final int commentBatchSize = 4;
    String user_id;
    private HomeAdapter adapter;
    private Application application;
    private LiveData<PagedList<Home_Post_Response.Post>> homePagedList;

    public ProfilePostsFragment(String user_id, Application application) {
        this.user_id = user_id;
        this.application = application;
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutI