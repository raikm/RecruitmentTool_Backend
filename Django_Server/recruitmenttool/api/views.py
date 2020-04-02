from rest_framework import viewsets
from .serializers import InformationRequestSerializer
from .models import InformationRequest, UploadFragment
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer, TemplateHTMLRenderer
from .helper import handle_uploaded_file

class InformationRequestViewSet(viewsets.ModelViewSet):
    #model = InformationRequest
    #queryset = InformationRequest.objects.all()
    queryset = UploadFragment.objects.all()
    serializer_class = InformationRequestSerializer

    @csrf_exempt
    @api_view(('POST',))
    def post(request):
        if request.method == 'POST':
            dataList = request.FILES.getlist('file')
            #TODO: is valid sollte mit einbezogen werden
            #serializer = InformationRequestSerializer(data=request.data)
            #if serializer.is_valid():
            newInformation=InformationRequest(name=request.data['name'], xPath=request.data['xPath'])
            newInformation.save()
            if dataList:
                for file in dataList:
                    destination = handle_uploaded_file(str(file), file)
                    newUploadFragment=UploadFragment(path=destination, upload=newInformation)
                    newUploadFragment.save()

                return Response("CREATED", status=status.HTTP_201_CREATED)
            else:
                return Response("NO FILES PROVIDED", status=status.HTTP_400_BAD_REQUEST)

        return Response(status=status.HTTP_400_BAD_REQUEST)
