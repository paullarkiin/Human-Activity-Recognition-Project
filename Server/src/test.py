import unittest
from unittest.mock import patch, Mock
import pred
import activity
from app import app, getBarChartActivityInfo

#set up testing class with unit test package
class test_response(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()

    def tearDown(self):
        pass

    def test_predict_route_OK(self):
        #Send a GET request to the endpoint
        response = self.app.get('/predict')
        # Check that the response is a success 
        self.assertEqual(response.status_code, 200)

    def test_with_activities_route_OK(self):
        response = self.app.get("/activities")
        self.assertEqual(response.status_code, 200)

    def test_mean_route_OK(self):
        response = self.app.get('/activities/mean')
        self.assertEqual(response.status_code, 200)

    def test_bar_chart_route_OK(self):
        response = self.app.get('/activities/chart/bar')
        self.assertEqual(response.status_code, 200)

    def test_acceleration_route_OK(self):
        response = self.app.get('/activities/chart/line/acceleration')
        self.assertEqual(response.status_code, 200)

    def test_std_route_OK(self):
        response = self.app.get('/activities/chart/line/std')
        self.assertEqual(response.status_code, 200)

    def test_angle_route_OK(self):
        response = self.app.get('/activities/chart/line/angle')
        self.assertEqual(response.status_code, 200)

    def test_energy_route_OK(self):
        response = self.app.get('/activities/chart/line/energy')
        self.assertEqual(response.status_code, 200)

    def test_with_incorrect_route(self):
        response = self.app.get("/")
        self.assertEqual(response.status_code, 404)


    #test if expection banch of try catch and will be executed
    def test_getBarChartActivityInfo_error(self):
        def mock_pandasActivityInfoJson():
            raise Exception('Something went wrong')

        # Patch the pandasActivityInfoJson function to use the mock function
        with patch('activity.pandasActivityInfoJson', new=mock_pandasActivityInfoJson):
            # Send a GET request to the endpoint
            response = self.app.get('/activities/chart/bar')

        # Check that the response is a server error
        self.assertEqual(response.status_code, 500)

 
    def test_predict_error(self):
        def mock_predication():
            raise Exception('Something went wrong')

        with patch('pred.prediction', new=mock_predication):
            response = self.app.get('/predict')

        self.assertEqual(response.status_code, 500)

    def test_getActivityInformation_error(self):
        def mock_pandasActivityInfoJson():
            raise Exception('Something went wrong')

        with patch('activity.pandasActivityInfo', new=mock_pandasActivityInfoJson):
            response = self.app.get('/activities')

        self.assertEqual(response.status_code, 500)

    def test_getActivityMeanInformation_error(self):
        def mock_getActivityMeanInformation():
            raise Exception('Something went wrong')

        with patch('activity.describeModelInfo', new=mock_getActivityMeanInformation):
            response = self.app.get('/activities/mean')

        self.assertEqual(response.status_code, 500)

    def test_getAccelerationLineChartInfo_error(self):
        def mock_getAccelerationLineChartInfo():
            raise Exception('Something went wrong')

        with patch('activity.chartInfo', new=mock_getAccelerationLineChartInfo):
            response = self.app.get('/activities/chart/line/acceleration')

        self.assertEqual(response.status_code, 500)

    def test_getEnergyLineChartInfo_error(self):
        def mock_getEnergyLineChartInfo():
            raise Exception('Something went wrong')

        with patch('activity.chartInfo', new=mock_getEnergyLineChartInfo):
            response = self.app.get('/activities/chart/line/energy')

        self.assertEqual(response.status_code, 500)

    def test_getStdLineChartInfo_error(self):
        def mock_getStandardDevLineChartInfo():
            raise Exception('Something went wrong')

        with patch('activity.chartInfo', new=mock_getStandardDevLineChartInfo):
            response = self.app.get('/activities/chart/line/std')

        self.assertEqual(response.status_code, 500)


    def test_getAngleLineChartInfo_error(self):
        def mock_getAccelerationLineChartInfo():
            raise Exception('Something went wrong')

        with patch('activity.chartInfo', new=mock_getAccelerationLineChartInfo):
            response = self.app.get('/activities/chart/line/angle')

        self.assertEqual(response.status_code, 500)
        
if __name__ == '__main__':
    unittest.main()


